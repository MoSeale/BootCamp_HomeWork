import os
import csv

# User to get third element from the list
def take_third(elem):
	return elem[2]

# Import CSV file from Folder
pybank_csv = os.path.join("Resources","budget_data.csv")
with open(pybank_csv, 'r') as input_file:
	csv_reader = csv.reader(input_file, delimiter=",")
	csv_header = next(input_file)
	line_count = 0
	date_list = []
	rev_list = []
	check = []
	val = 0

	for row in csv_reader:
		if line_count == 0:

			date_list.append(row[0])
			rev_list.append(int(row[1]))
			check.append(0)
			val=int(row[1])
			line_count += 1
		elif line_count == 1:
			date_list.append(row[0])
			rev_list.append(int(row[1]))
			check.append(int(row[1])-val)
			val = (int(row[1]))
			line_count += 1
		else:
			date_list.append(row[0])
			rev_list.append(int(row[1]))
			check.append(int(row[1]) - val )
			val = (int(row[1]))
			line_count += 1

# Appends the 3 list together
newlist = list(zip(date_list, rev_list, check))

# Sortes the list by increase
newlist1 = sorted(newlist, key=take_third)

# Prints final results to screen
print ('Financial Analysis')
print ('------------------')
print ('Total Months: {:}'.format(len(date_list)))
print ('Total: ${:.2f}'.format(sum(rev_list)))
print ('Average Change: ${:.2f}'.format(sum(check) / (len(newlist)-1)))
print ('Greatest Increase in Profits: ', newlist1[len(newlist1)-1][0], '${:.2f}'.format(newlist1[len(newlist1)-1][2]))
print ('Greatest Decrease in Profits: ', newlist1[0][0], '${:.2f}'.format(newlist1[0][2]))

# Prints similar info out to file

results_txt = os.path.join("Output","financial_out.txt")
text_file = open(results_txt, "w")
text_file.write ('Financial Analysis\n')
text_file.write ('------------------\n')
text_file.write('Total Months: {:}'.format(len(date_list))+ '\n')
text_file.write ('Total: ${:.2f}'.format(sum(rev_list))+ '\n')
text_file.write ('Average Change: ${:.2f}'.format(sum(check) / len(newlist)-1)+ '\n')
text_file.write('Greatest Increase in Profits: ' + newlist1[len(newlist1)-1][0] + ' ${:.2f}'.format(newlist1[len(newlist1)-1][2]) + '\n')
text_file.write('Greatest Decrease in Profits: ' + newlist1[0][0] + ' ${:.2f}'.format(newlist1[0][2]) + '\n')
text_file.close()