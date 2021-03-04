function write_matrix2txt()
value1 = 0.001341965359843; %4
value2 = 0.004076530817924; %8
value3 = 0.007939997843478; %8
value4 = 0.009915857326704; %4
value5 = 0.012383407207636; %4
value6 = 0.024119583762554; %8
value7 = 0.030121714902657; %4
value8 = 0.046978534350397; %4
value9 = 0.058669089490849; %4
value10 = 0.073268826056006;%1


txt_file = fopen('D:\matrix.txt','w');
for i=0:255
   fprintf(txt_file,'%.18f, ',value10*i); 
end
fclose('all');
end

