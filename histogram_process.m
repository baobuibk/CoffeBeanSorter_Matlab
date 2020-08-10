function anh = histogram_process(anh)
anh = double(anh);
[hang,cot] = size(anh);
kichthuoc  = hang*cot;
matdo      = zeros(1,256);
mucxammoi  = zeros(1,256);
for i=1:hang
    for j=1:cot
        matdo(1,anh(i,j)+1) =  matdo(1,anh(i,j)+1)+1;
    end
end
%=====================================================%
for i=0:255
   if i==0
       matdo(1,i+1) = matdo(1,i+1);
   else 
       matdo(1,i+1) = matdo(1,i+1)+ matdo(1,i);
   end
   mucxammoi(1,i+1) = uint8((matdo(1,i+1)/kichthuoc)*255);
end
%=====================================================%
for i=1:hang
    for j=1:cot
        anh(i,j)= mucxammoi(1,anh(i,j)+1);
    end
end
end

