function varargout = screenGene(varargin)
% SCREENGENE MATLAB code for screenGene.fig
%      SCREENGENE, by itself, creates a new SCREENGENE or raises the existing
%      singleton*.
%
%      H = SCREENGENE returns the handle to a new SCREENGENE or the handle to
%      the existing singleton*.
%
%      SCREENGENE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCREENGENE.M with the given input arguments.
%
%      SCREENGENE('Property','Value',...) creates a new SCREENGENE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before screenGene_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to screenGene_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help screenGene

% Last Modified by GUIDE v2.5 23-Apr-2015 15:57:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @screenGene_OpeningFcn, ...
                   'gui_OutputFcn',  @screenGene_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before screenGene is made visible.
function screenGene_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to screenGene (see VARARGIN)

% Choose default command line output for screenGene
handles.output = hObject;

headSamples = getappdata(0, 'headSamples');
headSeries = getappdata(0, 'headSeries');
set(handles.gplName, 'String', headSeries.platform_id);
% gseMatrixData = getappdata(0,'gseMatrixData');
% selectGSEMatrixData = getappdata(0,'selectGSEMatrixData');
% dmwrite(gseMatrixData,'original.txt');
% dmwrite(selectGSEMatrixData,'selected.txt');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes screenGene wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = screenGene_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function gplName_Callback(hObject, eventdata, handles)
% hObject    handle to gplName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gplName as text
%        str2double(get(hObject,'String')) returns contents of gplName as a double


% --- Executes during object creation, after setting all properties.
function gplName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gplName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function logThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to logThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of logThreshold as text
%        str2double(get(hObject,'String')) returns contents of logThreshold as a double


% --- Executes during object creation, after setting all properties.
function logThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in getGPLFile.
function getGPLFile_Callback(hObject, eventdata, handles)
% hObject    handle to getGPLFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global probeID;
%global geneSymbol;

global GENE_SYM_SORT;

name = get(handles.gplName,'String');
if(~isempty(name))
    filename = [name,'.annot'];
else   
    errordlg('Please Start from platform!','ERROR');
    return;    
end
if exist(filename,'file')==2
    try
%        msgbox('The file is found in your computer, the operation will continue!', '');
        hReadGPLFile = msgbox('The Operation is under way...');
        [probeID, geneSymbol] = gseAnnotRead(filename);
        close(hReadGPLFile);
        msgbox(['Read the GPL file ',filename,' successful.Please click to close.']);
    catch
        close(hReadGPLFile);
        errordlg('Error! Please Check!');
        return;
    end
else
    try
        msgbox(['It is going to download', filename, 'since there is No such file in Your Computer.'],'Hint');
        hDownloadGPLFile = msgbox('The File is Dowloading...');
        getgeodata(name,'ToFile',filename);
        close(hDownloadGPLFile);
    catch
        close(hDownloadGPLFile);
        errordlg('There is no such a GPL file exist in the Database, please check your input is correct!','ERROR');
        return;
    end
    if(exist(filename,'file')==2)
        msgbox('Download the file Success!');
    else
        msgbox('Download Fail, Please try again!');
        return;
    end
end
selectGSEMatrixData = getappdata(0,'selectGSEMatrixData');
probeID = probeID(1:end-1);
geneSymbol = geneSymbol(1:end-1);
%dmwrite(selectGSEMatrixData,'original.txt');
%selectGSEMatrixData = rownames(selectGSEMatrixData, ':', geneSymbol);
setappdata(0, 'selectGSEMatrixData', selectGSEMatrixData);
%dmwrite(selectGSEMatrixData,'original.txt');
[sortID, sortInd]= sort(probeID);

%disp(sortID);   %MY
%disp(sortInd);  %MY: display the index
GENE_SYM_SORT = geneSymbol(sortInd);
set(handles.step_1, 'Foregroundcolor', [0,0,1]);
%disp(GENE_SYM_SORT);  %MY:show the geneSymbol by index


% --- Executes on button press in log.
function log_Callback(hObject, eventdata, handles)
% hObject    handle to log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Operate...');
global GENE_SYM_SORT;
if (isempty( GENE_SYM_SORT))
    errordlg('Please get the GPL Data!');
    return;
end
selectGSEMatrixData = getappdata(0, 'selectGSEMatrixData');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% begin:    log
logThreshold = get(handles.logThreshold,'String');
if (isempty(logThreshold))
    errordlg('Please input the Threshold!');
    return;
end
if (str2double(logThreshold) <= 0)
    errordlg('Please input the Correct Threshold!');
    return;
end
if max(max(selectGSEMatrixData)) > logThreshold
    selectGSEMatrixData = log2(selectGSEMatrixData);
end
setappdata(0, 'selectGSEMatrixData', selectGSEMatrixData);
%%%%  end:    log
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close(h);
set(handles.step_2, 'Foregroundcolor', [0,0,1]);
msgbox('log success!');


% --- Executes on button press in normalize.
function normalize_Callback(hObject, eventdata, handles)
% hObject    handle to normalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectGSEMatrixData = getappdata(0,'selectGSEMatrixData');
setappdata(0, 'selectGSEMatrixData', selectGSEMatrixData);
set(handles.step_3, 'Foregroundcolor', [0,0,1]);


% --- Executes on button press in boxPlot.
function boxPlot_Callback(hObject, eventdata, handles)
% hObject    handle to boxPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in NextToCal.
function NextToCal_Callback(hObject, eventdata, handles)
% hObject    handle to NextToCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 try
     calculateProcess();
 catch
    errordlg('Please check the information!');
end


% --- Executes on button press in screenGene.
function screenGene_Callback(hObject, eventdata, handles)
% hObject    handle to screenGene (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Operate...');
global GENE_SYM_SORT
selectGSEMatrixData = getappdata(0,'selectGSEMatrixData');

%[sortID2, sortInd2]= sort(selectGSEMatrixData.rownames);

%Filter out probes w/o gene names, low exp value and low a data.
%geoDataSort('---',:)= [];%remove data with no gene names
%geoDataSort = selectGSEMatrixData(sortInd2, :);

%selectGSEMatrixData('---',:)= [];
%remove data with lowest 20% absolute exp value shared by all samples
%dmwrite(selectGSEMatrixData,'original.txt');
disp(size(selectGSEMatrixData,1));
absoluteExpVal = str2double(get(handles.absoluteExpVal, 'String')); 
if absoluteExpVal>100||absoluteExpVal<0
    msgbox('The scope of absoluteExpVal is 0-100!');
return ;
end
[mask, geoDataFilter, geneSymFilter]= genelowvalfilter(selectGSEMatrixData, GENE_SYM_SORT, 'percentile', absoluteExpVal);
disp(size(geoDataFilter,1));
%remove data with lowest 10% a across samples
variance = str2double(get(handles.variance, 'String')); 
if variance>100||variance<0
    msgbox('The scope of variance is 0-100!');
return ;
end
[mask, geoDataFilter2, geneSymFilter2] = genevarfilter(geoDataFilter, geneSymFilter,'percentile', variance);
disp(size(geoDataFilter2,1));
expData = double(geoDataFilter2);
%disp(expData);

%remove multiple gene exp values, retain only the gene exp value with
%highest mean for each gene using code HighExpressionProbes.m
[ind1, uniGene] = HighExpressionProbes(geneSymFilter2, geneSymFilter2, expData);
tmpExp = expData(ind1,:); %rows re-sorted to the alphabetic order of uniGene.
nSample = size(tmpExp, 2);
disp(size(expData,1));
[sortMean, sortInd] = sort(mean(tmpExp, 2), 'descend');

% 2015.1.26,end
% We should give the size of gene that we want to calculate;
%
topN = str2double(getappdata(0, 'topNApp'));
if topN > size(tmpExp,1)
%    msgbox('The topN is out of Matrixs range');
    topN = size(tmpExp,1);
end
finalExp = tmpExp(sortInd(1:topN), :); 
finalSym = uniGene(sortInd(1:topN));
setappdata(0, 'finalExp', finalExp);
setappdata(0, 'finalSym', finalSym);
setappdata(0, 'topN', topN);
close(h);
set(handles.step_4, 'Foregroundcolor', [0,0,1]);
msgbox('Screen the genes successful!');


function absoluteExpVal_Callback(hObject, eventdata, handles)
% hObject    handle to absoluteExpVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of absoluteExpVal as text
%        str2double(get(hObject,'String')) returns contents of absoluteExpVal as a double


% --- Executes during object creation, after setting all properties.
function absoluteExpVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to absoluteExpVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function variance_Callback(hObject, eventdata, handles)
% hObject    handle to variance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of variance as text
%        str2double(get(hObject,'String')) returns contents of variance as a double


% --- Executes during object creation, after setting all properties.
function variance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to variance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
