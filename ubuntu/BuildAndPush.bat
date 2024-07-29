echo off
cd /D O:\__BuildFolder\ubuntu
docker buildx build -t bedelaitre/ubuntu-xfce-firefox:latest .
docker push bedelaitre/ubuntu-xfce-firefox:latest