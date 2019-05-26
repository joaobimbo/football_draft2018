%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: /home/joao/Documents/MATLAB/Football/Doodle.xls
%    Worksheet: Poll
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

% Auto-generated by MATLAB on 2018/05/27 15:59:46

%% Import the data
function Doodle=import_doodle(fname)
%[~, ~, Doodle] = xlsread([fname],'Poll');
DoodTable=readtable(fname);
Doodle=[];
i=6;
k=1;
sz=size(DoodTable,2);
while ~strcmp(DoodTable.Poll_ScontentiFootball_{i},'Count')
    line=table2array(DoodTable(i,2:end));
    if(length(line)~=sz-1 || length(line{1})==0)
    %continue
    else
        vars=zeros(1,sz-1);
        for j=1:sz-1
        if strcmp(line{j},'OK')
            vars(j)=1;
        end
        end
        Doodle=[Doodle;string([k,vars])];
    end
    DoodTable.Poll_ScontentiFootball_{i}
    i=i+1;
    k=k+1;
end
%Doodle = [Doodle;
%    Doodle(7:idx-1,1:12    );
%Doodle = Doodle(7:29,:);

%Doodle = string(Doodle);
%Doodle(ismissing(Doodle)) = '';
%Doodle(:,2:end)=double(Doodle(:,2:end)=='OK');


end