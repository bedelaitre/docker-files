echo off
cd /D O:\__BuildFolder\alltube
docker buildx build -t bedelaitre/alltube:latest .
docker push bedelaitre/alltube:latest