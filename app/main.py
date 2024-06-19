from fastapi import FastAPI, HTTPException, Depends, Query
from sqlalchemy.orm import Session
from datetime import datetime
from typing import List, Optional
import models, schemas, crud
from database import SessionLocal, engine

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/arxiv/")
def scrape_arxiv(author: Optional[str] = "", title: Optional[str] = "", journal: Optional[str] = "", db: Session = Depends(get_db)):
    try:
        results = crud.search_arxiv(author, title, journal)
        query = schemas.Query(
            query=f"search_query=author:{author}+title:{title}+journal:{journal}",
            timestamp=datetime.now().isoformat(),
            status=200,
            num_results=len(results),
        )
        db_query = crud.create_query(db, query=query)
        for result in results:
            crud.create_result(db, query_id=db_query.id, result=result)
        return {"status": "success", "data": results}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/queries/")
def fetch_queries(query_start_time: datetime, query_end_time: Optional[datetime] = None, db: Session = Depends(get_db)):
    queries = crud.get_queries(db, query_start_time, query_end_time)
    return queries

@app.get("/results/")
def fetch_results(page: int = 0, items_per_page: int = 10, db: Session = Depends(get_db)):
    results = crud.get_results(db, page, items_per_page)
    return results
