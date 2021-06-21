# Test Plumber API

We want to test if the REST API is working correctly.
Therefore, we start 3 containers:
* The model provides the statistical models in R with its Plumber API.
* We insert data into a MongoDB (75 data points), whereas the last 50 events used for retraining consist
of 25 salmon and 25 walleye data.
```
docker-compose up
```
On [localhost](http://127.0.0.1:8000/__docs__/) we then can try out the Plumber API.
See all features by executing in this order:

###  1. Get Request
Try out the get request with the following parameters:
```
length:  95               |
height:  18               | - > weight: 4.92
species: salmon/walleye   |
```
For every species, we receive `weight: 4.92` because the model does not take the species into account.

### 2. Post Request
Retrain the model.
### 3. Get Request
Use the same parameters as above, but now you should obtain `weight: 4.73` for salmon and `weight: 2.68` for walleye.
Moreover, the `ModelTime` should have changed.