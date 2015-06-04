%
% Read the annot file to get probeID,geneSymbol(one column),geneBankAcc(one column).
% return a array contains:
% ID,Gene symbol, GenBank Accession
% arrange by vertical
%
function [probeID, geneSymbol, geneBankAcc] = gseAnnotRead(annotationFile)

fid = fopen(annotationFile);
if (fid < 0)
    probeID = [];
    geneSymbol = [];
    geneBankAcc = [];
else
%    fileExist = 1; %Useless
    tmpL = [];
    while (isempty(strfind(tmpL, '!platform_table_begin'))) &&(feof(fid)~=1) 
        tmpL = fgetl(fid);   %find the beginning of the data,identify by '!platform_table_begin'
    end;
    tmpL = fgetl(fid);
    headLine = textscan(tmpL, '%s', 'delimiter', '\t'); 
    headLine = headLine{1}; %read the head line in headLine
    nColumns = length(headLine);    %How many columns in the file
    textStr = strcat(repmat('%s ', 1, nColumns));   %
    A = textscan(fid, textStr, 'delimiter', '\t', 'bufSize', 4096*8-1);
    fclose(fid);
    
    probeID = A{1}; %the first column in the file :ID
%    headLine       %Useless
    ind1 = strmatch('Gene symbol', headLine);
    ind2 = strmatch('GenBank Accession', headLine);
    
    geneSymbol = A{ind1}; 
    geneBankAcc = A{ind2};
end;