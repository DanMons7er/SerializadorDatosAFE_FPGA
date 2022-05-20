import codecs
import serial
import time
import pandas as pd
import datetime
import keyboard

SerialObj = serial.Serial('COM5', 115200, timeout=0)
time.sleep(1)
writer = pd.ExcelWriter('Sampleo10MHzUserUEIA' + str(datetime.datetime.now().date()) + '.xlsx', engine='xlsxwriter')
data = [[],[],[],[]]
data_to_save = {}

while True:
    if keyboard.is_pressed('q'):
        break
    elif SerialObj.in_waiting >= 4:
        data_now = SerialObj.read(4)
        for i in range(4):
            data[i].append(data_now[i])

for k in range(2):
    i = 2*k
    final_data = []
    for j in range(len(data[i])):
        final_data.append(data[i][j]+data[i+1][j]*16**2)
    data_to_save[str(k+1)] = final_data

df = pd.DataFrame(data_to_save)

df.to_excel(writer, sheet_name='Sheet1', index=False)

writer.save()