#!/usr/bin/env python
import matplotlib.pyplot as plt


labels = ["03-Kincaid","01-ARI","06-Coleman-Liau","07-FleschReadingEase","05-GunningFogIndex",\
        "04-LIX","08-SMOGIndex","02-RIX"]
starting = 3
a = 0.01
metrics = range(starting, 8+starting)

results = []
for metric in metrics:
	myData = []
	with open('filesRatingsScores.csv', 'r') as file:
	    for line in file:
	        data = line.split(",")
	        value = float(data[metric])
	        myData.append(value)
	plt.clf()
	plt.xlabel("Medida")
	plt.ylabel("Cantidad")
	plt.title("Metrica " + labels[metric-starting])
	fig = plt.figure(1, figsize=(9, 6))
	# Create an axes instance
	ax = fig.add_subplot(111)
	# Create the histogram
	bp = ax.hist(myData, rwidth = 0.7, color = 'green')
	# Save the figure
	fig.savefig("histogram"+"/"+labels[metric-starting]+"histogram"+".png")