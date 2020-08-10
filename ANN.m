function  ANN()
%======================================
%257.774711141135696835  -1.983727219269821873  -22.504981531149287122  84.292970330603694151 
%2212.632359246225405514  -19.015059595008050763  -186.901901781056608343  444.752681519138434396 
%4535.814723686393335811  4.906791937069922227  -548.726413183499516890  1094.680675856473953900 
%         w0                     w1                     w2                         w3
%         1                      L                       b                        Hue     
% GOOD = -1
% BAD = 1
%value_W   = fopen('D:\W.txt','w');
%======================================INTITIALING VALUE
open_good = fopen('D:\B. WORK\LAB\REPORT + PAPER\Coffee_shap_color\Data\training_normal.txt');
open_bad  = fopen('D:\B. WORK\LAB\REPORT + PAPER\Coffee_shap_color\Data\training_color.txt');
GOOD      = fscanf(open_good,'%lf');
BAD       = fscanf(open_bad,'%lf');

[size_good,~]   = size(GOOD);         %438,347
[size_bad,~]    = size(BAD);
BADnew          = zeros(size_bad/5,5);
GOODnew         = zeros(size_good/5,5);

for i=0:size_good-1
    GOODnew((floor(i/5)+1),mod(i,5)+1) = GOOD(i+1,1);
%    GOOD1  ((floor(i/3)+1),mod(i,3)+1) = GOOD(i+1,1);
end

for i=0:size_bad-1
    BADnew ((floor(i/5)+1),mod(i,5)+1) = BAD(i+1,1);
end
%draw_plane(BADnew,GOODnew);

%L,b,Hue
groupBAD  = [BADnew(:,1),BADnew(:,3),BADnew(:,5)];
groupGOOD = [GOODnew(:,1),GOODnew(:,3),GOODnew(:,5)];

draw_plane(BADnew,GOODnew);
%trainning_ANN_3D(groupGOOD,groupBAD);
%test_result(groupGOOD,groupBAD);



                 
function test_result(groupA,groupB)

groupA = groupA';
groupB = groupB';
[~,size_grA] = size(groupA);
%[~,size_grB] = size(groupB);

groupA  = [ones(1,size_grA);groupA];
%groupB = [ones(1,size_grB);groupB];
LabelA   = -1*(ones(1,size_grA));
%LabelB   =  ones(1,size_grB);

w0 = 257.774711141135696835;  
w1 = -1.983727219269821873;    
w2 = -22.504981531149287122;  
w3 = 84.292970330603694151;
W  = [w0;w1;w2;w3];
mis_point = 0;
for ii=1:size_grA 
    yii = sgn(sum(groupA(:,ii).*W));
    if yii == LabelA(1,ii)
        continue;
    else 
        mis_point = mis_point + 1;
    end
end
percent = 1-mis_point/size_grA;
fprintf('mispoint = %d   percent = %.4f \n',mis_point, percent);


%====================================== PLOT VALUE

function draw_plane(BADnew,GOODnew)

L_bad           = BADnew(:,1);
b_bad           = BADnew(:,3);
Hue_bad         = BADnew(:,5);

L_good          = GOODnew(:,1);
b_good          = GOODnew(:,3);
Hue_good        = GOODnew(:,5);

%plot3(Chroma_bad,L_bad,b_bad,'o','color','r');
plot3(L_bad,b_bad,Hue_bad,'+','color','b');
hold on;
%plot3(Chroma_good,L_good,b_good,'+','color','b');
plot3(L_good,b_good,Hue_good,'o','color','r');
grid on;

%xlabel('Chroma');
%ylabel('L');
%zlabel('b');
xlabel('L');
ylabel('b');
zlabel('Hue');
%============================
w0 = 257.774711141135696835;  
w1 = -1.983727219269821873;    
w2 = -22.504981531149287122;  
w3 = 84.292970330603694151;


%w0 = -4613.461657564739653026;
%w2 = 42.451934716619170729;
%w3 = 1128.251975528505681723;
%w1 = -636.592821731821345566;
[x, y] = meshgrid(20:1:60,-10:1:30);

z = -(w1.*x + w2.*y + w0)/w3;
surf(x,y,z);

%hold on;


%0.165648729499780933  15.270881941401633242  10.179871284540144671  10.218879098476783440 



%================================================== USING FOR TRAINNING

function trainning_ANN_3D(groupA,groupB)

ON       = 1;
OFF      = 0;
MAX_LOOP = 1000001;

%mis_flag = OFF;
groupA = groupA';
groupB = groupB';
W = rand(4,1);

[~,size_grA] = size(groupA);
[~,size_grB] = size(groupB);
groupA  = [ones(1,size_grA);groupA];
groupB = [ones(1,size_grB);groupB];

Data    = [groupA,groupB];
Label   = [-1*(ones(1,size_grA)),ones(1,size_grB)];

Data_mix    = [Data;Label];
P = randperm(size_grA + size_grB);
Data_mix = Data_mix(:,P);
min_mis  = size_grA + size_grB;



for loop=0:MAX_LOOP
    %------------------------------------check misclassified
    mis_point = 0;
    for ii=1:(size_grA + size_grB)
        yii = sgn(sum(Data_mix(1:4,ii).*W));
        if yii == Data_mix(5,ii)                 %Label = Data_mix(5,ii);
            continue;
        else 
            mis_point = mis_point + 1;
        end
    end
    if min_mis > mis_point
        min_mis = mis_point;
        Wmin = W;
        fprintf('%.18f  %.18f  %.18f  %.18f \n',Wmin);
        fprintf('%d \n', min_mis);
    end

    %------------------------------------ update W
    for i=1:(size_grA+size_grB)
        yi = sgn(sum(Data_mix(1:4,i).*W));
        if yi == Data_mix(5,i)
            continue;
        else
            W  = W + Data_mix(5,i).*Data_mix(1:4,i);
%            fprintf('%.18f  %.18f  %.18f  %.18f \n',W);
            break;
        end
    end  
    %------------------------------------ abandon the end point
    if mod(loop,1000) == 0
        fprintf('Loop = %d \n', loop);
        fprintf('%.18f  %.18f  %.18f  %.18f \n',Wmin);
        fprintf('min_mis = %d \n', min_mis);
    end
end
%           fprintf(value_W,'%.18f   %.18f  %.18f \n',W(1,1),W(2,1),W(3,1));
fprintf('%.18f  %.18f  %.18f  %.18f \n',Wmin);
fprintf('%d \n', min_mis);



%==================================================
function y = sgn(x)

if x>0
   y =  1;
else
   y = -1;
end

%=====================================================
fclose('all');
