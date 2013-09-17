clc;clear;
path = '3';
file = dir([path '/*.bmp']);
threshold = 15;
img = [];
for i = 1 : length(file)
    img(:,:,i) = imread([path '/' file(i).name]);
    imG{i}=sum(255-img(:,:,i)')'>0;
end

for j = 1 : length(file)
    for i = 1 : length(file)
        if j==i
            S(j,i) = Inf;
            SS(j,i) = 0;
            continue
        end
        S(j,i) = sum((img(:,end,j)-img(:,1,i)).^2);
        SS(j,i) = sum(abs(imG{i}-imG{j}));
    end
end
START =[];
for i = 1 : length(file)
    left(find(S(:,i)==min(S(:,i)))) = i;
    if img(:,1,i)==255
        START(end+1) = i;
    end
end
Img = 1:i;
j = 1;

for i=1:length(file)
    pp = unique(SS(find(SS(:,i)<threshold),i));
    class=[];
    for j=1:length(pp)
         class = [class;find(SS(:,i)==pp(j))];
    end
    Class{i}=class;
end


%{
for i = 1:length(START)
    STARt=START(i);
    Img(find(Img==STARt)) = [];
    IMG{i} = img(:,:,STARt);
    while 1
        IMG{i} = [IMG{i} img(:,:,find(S(STARt,:)==min(S(STARt,:)))) ];
        STARt = find(S(STARt,:)==min(S(STARt,:)));
        Img(find(Img==STARt)) = [];
        if ~sum(find(S(STARt,:)==min(S(STARt,:)))~=START)
            break
        end
    end
        figure;imshow(IMG{i});
end
%imshow(IMG)
%}