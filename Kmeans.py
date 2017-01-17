#Author :Prudhvi Indana
#Data mining Assignment 1
'''
Implementation of KNN algorithm
'''

from __future__ import division
import numpy as np
import random
import math
import pandas as pd
import copy

random.seed(random.randrange(1,1000))


def KMean(data,CNumber,threshold):
    '''
    Implements K means algorithm in this method
    data :- data points passed as a two dimensional array, for convinience sake I am passing a numpy array
    CNumber :- number of centroids we need as output from data
    threshold :- minimum acceptable threashold between centroids and data points.
    Note :- I am using a distance matric in the method and not explectly passing it in this method.
    '''
    #centroids = chooseCentroids(data,CNumber)
    centroids = chooseRandomCentroids(data,CNumber)
    convergence = 10000
    while True:
        partitions = createPartitions(centroids,data,CNumber)
        newcentroids =  updatecentroids(partitions,centroids)
        convergence = checkconvergence(centroids,newcentroids,CNumber)
        if convergence < threshold:
            return partitions
        else:
            centroids = newcentroids

def chooseRandomCentroids(data,CNumber):
    return random.sample(data,CNumber)
    

def chooseCentroids(data,CNumber):
    '''
    This method chooses Cnumber centroids in the data passes to it by calculating minimum array having minimum elelments along column axis
    and minimum array having maximum elelments along column axis and getting difference between them and using this diffrence to create
    centroid points
    data :- data points passed as a two dimensional array, for convinience sake I am passing a numpy array
    Cnumber :- number of centroids we need as output from data
    '''
    
    minelements = np.amin(data,axis=0)
    maxelements = np.amax(data,axis=0)
    difference = (maxelements - minelements)/(CNumber+1)
    centroids = np.array([minelements+(n+1)*difference for n in range(CNumber) ])
    return centroids

def createPartitions(centroids,data,CNumber):
    '''
    This method is used to associate each data point to its nearest centroid
    centroids :- list of centroids
    data :- data points passes as numpy array
    '''
    partitions = {}
    
    for item in data:
        #print item
        distance = EuclidianDistance(item,centroids,CNumber)
        minvalue = np.argmin(distance)
        itemaslist = tuple(centroids[minvalue])
        if itemaslist in partitions:
            templist = partitions[itemaslist]
            #print templist
            templist.append(item)
            partitions[itemaslist] = templist
        else:
            templist = []
            templist.append(item)
            partitions[itemaslist] = templist
    return partitions 
        
        

def EuclidianDistance(datapoint1,centroids,CNumber):
    '''
    Returns euclidian dustance between given two points
    '''
    datapoint1 = np.array([datapoint1,]*CNumber)
    distanceFromCentroids = centroids - datapoint1
    return np.sqrt(np.diagonal(distanceFromCentroids.dot(distanceFromCentroids.T)))

def updatecentroids(partitions,centroids):
    '''
	This methods updates centroids based on partitions and old cenetroids.
    '''
    newcentroid = []
    for centroid in centroids:
        partitionelements = partitions[tuple(centroid)]
        
        totpartionelements = len(partitionelements)
        centroid = sum(partitionelements)/totpartionelements
        newcentroid.append(centroid)
    return newcentroid

def checkconvergence(centroids,newcentroids,CNumber):
    '''
	This methods ralculates new centroid based on old value.
    '''
    convergence = [centroids[i]-newcentroids[i] for i in range(CNumber)]
    return np.sum([math.sqrt((x).dot(x.T)) for x in convergence])/CNumber


totdata = pd.DataFrame.from_csv("BreastCancerdatamean.csv")
#totdata.drop_duplicates(keep='first')
#data = np.loadtxt("BreastCancerdatamean.csv",delimiter=',')
totdata = np.array(totdata)

outputclass = np.array(totdata[:,8])
inputdata = np.array(totdata[:,:8])



for _ in range(20):
    locerror = 0
    error = []
    for k in range(1,6):
        partitions = KMean(inputdata,k,0.1)
        totdatabkup = totdata[:,:8]
        bigdict = []
        for i in partitions.keys():
            #print len(partitions[i])
            tempdict = {}
            for j in partitions[i]:
                for temp in range(len(totdatabkup)):
                    if all(totdatabkup[temp] == j):
                        if outputclass[temp] in tempdict:
                            tempdict[outputclass[temp]] += 1
                        else:
                            tempdict[outputclass[temp]] = 1
                        break
            bigdict.append(tempdict)
        #print bigdict
        for itemdict in bigdict:
            #for  in sorted(itemdict.values()):
            locallist = sorted(itemdict.values())
            locerror +=  locallist[0]/sum(locallist)
            #print error
        error.append(locerror)
    print [_,sum(error)]
    















    
