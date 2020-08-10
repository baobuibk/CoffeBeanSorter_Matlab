function nguongk = np_otsus_process(img)

[row,col] = size(img);
kichthuoc = row*col;
matdo     = zeros(1,256);
psai      = zeros(1,256);
for r=1:row
    for c=1:col
        matdo(1,img(r,c)+1)= matdo(1,img(r,c)+1) + 1;                      %vi tri mucxam = muc xam + 1
    end
end

%--------------------------------------------------------------------------%xac suat xuat hien
for mt = 1:256                                                             
    matdo(1,mt) = matdo(1,mt)/kichthuoc;
end
%--------------------------------------------------------------------------% P1 va P2
for K=0:255
    for mx1=0:K
        if mx1 == 0
            P1 = matdo(1,mx1+1);
        else 
            P1 = P1 + matdo(1,mx1+1);
        end
    end
    P2 = 1 - P1;
%--------------------------------------------------------------------------% M1 va M2    
    for mx2=0:K
        if mx2==0
            M1 = (mx2*matdo(1,mx2+1))/P1;
        else
            M1 = (mx2*matdo(1,mx2+1))/P1+ M1;
        end
    end
    for mx3=(K+1):255
        if mx3 == (K+1)
            M2 =(mx3*matdo(1,mx3+1))/P2;
        else
            M2 = (mx3*matdo(1,mx3+1))/P2 + M2;
        end
    end
%--------------------------------------------------------------------------%     
    MG = M1*P1 + M2*P2;
    psai(1,K+1) = P1*(M1-MG)^2 + P2*(M2-MG)^2;
end
[~,nguongk] = max(psai);
nguongk = nguongk - 1;
end






