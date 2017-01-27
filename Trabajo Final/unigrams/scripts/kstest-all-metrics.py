#!/usr/bin/env python
from scipy import stats
import operator, math

def evaluate_results(n1, n2, a, pvalue, statistic):
    e_a = math.sqrt(-1*float(1/2.0)*math.log(a/2))
    condition = e_a * math.sqrt(float(n1+n2) / float(n1*n2))
    if (pvalue < a) and (condition < statistic):
        print "Hipotesis nula rechazada",
    else:
        print "Hipotesis nula NO rechazada",
    print "("+str(pvalue), "<", str(a), "y", str(condition), "<", str(statistic)+")"


labels = ["Kincaid","ARI","Coleman-Liau","FleschReadingEase","GunningFogIndex",\
        "LIX","SMOGIndex","RIX"]
folder="plots"
starting = 3
a = 0.01
metrics = range(starting, 8+starting)

results = []
for metric in metrics:
    values_low_rating = []
    values_high_rating = []
    result = []
    with open('filesRatingsScores.csv', 'r') as file:
        for line in file:
            data = line.split(",")
            score = float(data[1])
            value = float(data[metric])
            if score == 4.5 or score == 5.0:
                values_high_rating.append(value)
            if score == 3.0 or score == 2.5 or score == 2.0 or score == 1.5:
                values_low_rating.append(value)
    [statistic, pvalue] = stats.ks_2samp(values_high_rating, values_low_rating)
    results.append(tuple((labels[metric-starting], statistic, pvalue)))

n1 = len(values_low_rating)
n2= len(values_high_rating)
results = sorted(results, key=operator.itemgetter(2), reverse=True)
for result in results:
    label, statistic, pvalue = result
    print label
    print "pvalue: " + str(pvalue) + ", statistic: " + str(statistic)
    evaluate_results(n1,n2,a,pvalue,statistic)
    print
