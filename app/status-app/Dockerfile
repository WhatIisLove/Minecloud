FROM python:3.11-slim
RUN pip install flask mcstatus
COPY app.py .
EXPOSE 5000
CMD ["python", "app.py"]
