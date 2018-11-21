clear
docker-compose -f docker-compose.yml up --build
docker create --name TempCopy sampledotnetcore:latest
docker cp TempCopy:/app/. ../../Output
docker rm TempCopy