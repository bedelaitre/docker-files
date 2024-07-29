echo off
cd /D O:\__BuildFolder\openvpn-light
docker buildx build -t bedelaitre/openvpn-light:latest .
docker push bedelaitre/openvpn-light:latest
