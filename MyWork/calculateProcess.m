function varargout = calculateProcess(varargin)
% CALCULATEPROCESS MATLAB code for calculateProcess.fig
%      CALCULATEPROCESS, by itself, creates a new CALCULATEPROCESS or raises the existing
%      singleton*.
%
%      H = CALCULATEPROCESS returns the handle to a new CALCULATEPROCESS or the handle to
%      the existing singleton*.
%
%      CALCULATEPROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALCULATEPROCESS.M with the given input arguments.
%
%      CALCULATEPROCESS('Property','Value',...) creates a new CALCULATEPROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before calculateProcess_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to calculateProcess_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calculateProcess

% Last Modified by GUIDE v2.5 26-Apr-2015 14:35:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calculateProcess_OpeningFcn, ...
                   'gui_OutputFcn',  @calculateProcess_OutputFcn, ...
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


% --- Executes just before calculateProcess is made visible.
function calculateProcess_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calculateProcess (see VARARGIN)

% Choose default command line output for calculateProcess
handles.output = hObject;
% gseMatrixData = getappdata(0,'gseMatrixData');
% selectGSEMatrixData = getappdata(0,'selectGSEMatrixData');
% dmwrite(gseMatrixData,'original.txt');
% dmwrite(selectGSEMatrixData,'selected.txt');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes calculateProcess wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = calculateProcess_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function gammaParam_Callback(hObject, eventdata, handles)
% hObject    handle to gammaParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gammaParam as text
%        str2double(get(hObject,'String')) returns contents of gammaParam as a double


% --- Executes during object creation, after setting all properties.
function gammaParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gammaParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tParam_Callback(hObject, eventdata, handles)
% hObject    handle to tParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tParam as text
%        str2double(get(hObject,'String')) returns contents of tParam as a double


% --- Executes during object creation, after setting all properties.
function tParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lambdaParam_Callback(hObject, eventdata, handles)
% hObject    handle to lambdaParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lambdaParam as text
%        str2double(get(hObject,'String')) returns contents of lambdaParam as a double


% --- Executes during object creation, after setting all properties.
function lambdaParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lambdaParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function betaParam_Callback(hObject, eventdata, handles)
% hObject    handle to betaParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of betaParam as text
%        str2double(get(hObject,'String')) returns contents of betaParam as a double

% --- Executes during object creation, after setting all properties.
function betaParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to betaParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function minClusterSize_Callback(hObject, eventdata, handles)
% hObject    handle to minClusterSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minClusterSize as text
%        str2double(get(hObject,'String')) returns contents of minClusterSize as a double


% --- Executes during object creation, after setting all properties.
function minClusterSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minClusterSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mergedCluster = getappdata(0, 'mergedCluster');
finalSym = getappdata(0, 'finalSym');
[filename ,pathname]=uiputfile({'*.txt','TXT-files(*.txt)'},'Save');
if filename == 0
    return;
end
outputName = strcat(pathname, filename);
fid = fopen(outputName, 'w');
for i = 1 : length(mergedCluster)
    tmp = mergedCluster{i};
    for j = 1 : length(tmp)
        fprintf(fid, '%s\t', finalSym{tmp(j)});
    end;
    fprintf(fid, '\n');
end
fclose(fid);
msgbox('Success!Please check the Result file!');


% --- Executes on button press in normalize.
function normalize_Callback(hObject, eventdata, handles)
% hObject    handle to normalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectGSEMatrixData = getappdata(0,'selectGSEMatrixData');
setappdata(0, 'selectGSEMatrixData', selectGSEMatrixData);

% --- Executes on button press in boxPlot.
function boxPlot_Callback(hObject, eventdata, handles)
% hObject    handle to boxPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in identifyCEModules.
function identifyCEModules_Callback(hObject, eventdata, handles)
% hObject    handle to identifyCEModules (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h = msgbox('Operate...');
finalExp = getappdata(0, 'finalExp');
%finalSym = getappdata(0, 'finalSym');
topN = getappdata(0, 'topN');

%%%%%%%%%%% Step 1 - Compute PCC matrix  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nGene = topN;
if numel(find(isnan(finalExp))) > 0    % if there is Nan in finalExp
    tic
    cMatrix = zeros(nGene, nGene);
    for i = 1 : nGene-1
        if (mod(i, 200) == 0)
            i;
            toc
        end;
        cMatrix(i+1:end,i) = massivePCC_withNaN(finalExp(i+1:end, :), finalExp(i,:), 10);
    end;
    cMatrix = cMatrix + cMatrix';
else
    cMatrix = massivePCC_withoutNaN(finalExp);
end
%cMatrix = massivePCC_withoutNaN(finalExp);
%%%%%%%% Step 2 - identify co-expression modules %%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Algorithm parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gamma = str2double(get(handles.gammaParam, 'String')); 
t = str2double(get(handles.tParam, 'String')); 
lambda = str2double(get(handles.lambdaParam, 'String'));
%gamma 0-1,normalization0.4,0.75
%t>=1
%lamda>=1
if gamma<0||gamma>1
    msgbox('The scope of gamma is 0-1!');
return ;
end
if t<1
    msgbox('The scope of t is =>1!');
return ;
end
if lambda<1
    msgbox('The scope of lambda is >=1!');
return ;
end
%%%%%%%% Run the algorithm
C = localMaximumQCM(abs(cMatrix), gamma, t, lambda);
setappdata(0, 'C', C);
close(h);
set(handles.step_5, 'Foregroundcolor', [0,0,1]);
msgbox('Identify co-expression modules Successful!');


% --- Executes on button press in mergeNetwork.
function mergeNetwork_Callback(hObject, eventdata, handles)
% hObject    handle to mergeNetwork (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Operate...');
C = getappdata(0, 'C');
%%%%%%%% Step 3 - Merge the overlapped networks %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Allowed overlap ratio threshold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
beta = str2double(get(handles.betaParam, 'String'));  
minClusterSize = str2double(get(handles.minClusterSize, 'String')); 
%beta 0-1,0.4or0.5
%minClusterSize>=2,10
if beta>1||beta<0
    msgbox('The scope of beta is 0-1!');
return ;
end
if minClusterSize<2
    msgbox('The scope of minClusterSize is >=2!');
return ;
end
%%%%%%%% Sort and iteratively merge %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sizeC = zeros(1, length(C));
for i = 1 : length(C)
    sizeC(i) = length(C{i});
end;

[sortC, sortInd] = sort(sizeC, 'descend');
C = C(sortInd);

ind = find(sortC >= minClusterSize);

mergedCluster = C(ind);
mergeOccur = 1; 
currentInd = 0;

while mergeOccur == 1
    mergeOccur = 0;
    while currentInd < length(mergedCluster)
        currentInd = currentInd + 1;
%        excludeInd = [];
        if (currentInd < length(mergedCluster))
            keepInd = 1 : currentInd;
            for j = currentInd+1 : length(mergedCluster)
                interCluster = intersect(mergedCluster{currentInd}, mergedCluster{j});
                if length(interCluster) >= beta*min(length(mergedCluster{j}), length(mergedCluster{currentInd}))
                    mergedCluster{currentInd} = union(mergedCluster{currentInd}, mergedCluster{j});
                    mergeOccur = 1;
                else
                    keepInd = [keepInd, j];
                end;
            end;
            mergedCluster = mergedCluster(keepInd);
%            length(mergedCluster);
        end;
    end;
    sizeMergedCluster = zeros(1, length(mergedCluster));
    for i = 1 : length(mergedCluster)
        sizeMergedCluster(i) = length(mergedCluster{i});
    end;
    [sortSize, sortMergedInd] = sort(sizeMergedCluster, 'descend');
    mergedCluster = mergedCluster(sortMergedInd);
    currentInd = 0;
end;
setappdata(0, 'mergedCluster', mergedCluster);
close(h);
set(handles.step_6, 'Foregroundcolor', [0,0,1]);
msgbox('Merge the overlapped networks Successful!');
