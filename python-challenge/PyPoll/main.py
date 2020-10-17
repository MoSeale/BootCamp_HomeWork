import os
import csv

# User to get third element from the list
def take_second(elem):
    return elem[1]

pypoll_csv = os.path.join("Resources", "election_data.csv")
with open(pypoll_csv, 'r') as input_file: 

	csv_reader = csv.reader(input_file, delimiter=",")
	csv_header = next(input_file)
	line_count = 0
	voter_id = []
	county_name = []
	candidate_name = []
	can1 = []
	can2 = []
	can3 = []
	can4 = []

	for row in csv_reader:
		if line_count == 0:
			line_count += 1
		else:
			voter_id.append(row[0])
			county_name.append(row[1])
			candidate_name.append(row[2])
			line_count += 1

newlist = (list(zip(voter_id, county_name, candidate_name)))


#print (newlist)

#

for i in newlist:
	if i[2] == 'Khan':
		can1.append(i)

for i in newlist:
	if i[2] == 'Correy':
		can2.append(i)

for i in newlist:
	if i[2] == 'Li':
		can3.append(i)

for i in newlist:
	if i[2] == "O'Tooley":
		can4.append(i)

total = len(newlist)
total_can1 = len(can1)
total_can2 = len(can2)
total_can3 = len(can3)
total_can4 = len(can4)

candidate = ['Khan', 'Correy', 'Li', "O'Tooley"]
candiate_total = [total_can1, total_can2, total_can3, total_can4]

final_winner = sorted(list(zip(candidate, candiate_total)), key=take_second, reverse=True)
		
print ('Election Results')
print ('-----------------------')
print ('Total Votes: ', total)
print ('-----------------------')
print ('Khan: {:.3%} '.format(total_can1/total) ,'(', total_can1,')' )
print ('Correy: {:.3%} '.format(total_can2/total) ,'(', total_can2,')' )
print ('Li: {:.3%} '.format(total_can3/total) ,'(', total_can3,')' )
print ("O'Tooley: {:.3%} ".format(total_can4/total) ,'(', total_can4,')' )
print ('-----------------------')
print ('Winner: ', final_winner[0][0], final_winner[0][1])

#Writes output to file
results_txt = os.path.join("Output", "elections_out.txt")

text_file = open(results_txt, "w")
text_file.write ('Election Results\n')
text_file.write ('-----------------------\n')
text_file.write ('Total Votes: '+ str(total) + '\n')
text_file.write ('-----------------------\n')
text_file.write ('Khan: {:.3%} '.format(total_can1/total) + ' (' + str(total_can1) +') '+ '\n') 
text_file.write ('Correy: {:.3%} '.format(total_can2/total) + ' ('+ str(total_can2) +')' + '\n')
text_file.write ('Li: {:.3%} '.format(total_can3/total) + ' ('+ str(total_can3)+')'+ '\n')
text_file.write ("O'Tooley: {:.3%} ".format(total_can4/total) +'('+ str(total_can4)+')'+ '\n')
text_file.write ('-----------------------\n')
text_file.write ('Winner: ' + str(final_winner[0][0]) + ' ' +str(final_winner[0][1])+ '\n')
text_file.close()