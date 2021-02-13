function CostValuesBBRfunc2struct = importBBRfile(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as a matrix.
%   COSTVALUESBBRFUNC2STRUCT = IMPORTFILE(FILENAME) Reads data from text
%   file FILENAME for the default selection.
%
%   COSTVALUESBBRFUNC2STRUCT = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads
%   data from rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   CostValuesBBRfunc2struct = importfile('CostValues_BBR_func2struct.txt', 2, 136);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2021/02/08 17:53:18

%% Initialize variables.
delimiter = ' ';
if nargin<=2
    startRow = 2;
    endRow = inf;
end

%% Format for each line of text:
%   column1: text (%s)
%	column2: text (%s)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
CostValuesBBRfunc2struct = table(dataArray{1:end-1}, 'VariableNames', {'subID','taskName','costBefore','costAfterSPE','costAfterEPI','costAfterGRE','costAfterGREEPI','costAfterGRESPE'});

