docker image build -t stozuka/multi-client:latest -t stozuka/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker image build -t stozuka/multi-server:latest -t stozuka/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker image build -t stozuka/multi-worker:latest -t stozuka/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker
docker push stozuka/multi-client:latest
docker push stozuka/multi-server:latest
docker push stozuka/multi-worker:latest
docker push stozuka/multi-client:$SHA
docker push stozuka/multi-server:$SHA
docker push stozuka/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stozuka/multi-server:$SHA
kubectl set image deployments/client-deployment client=stozuka/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stozuka/multi-worker:$SHA
