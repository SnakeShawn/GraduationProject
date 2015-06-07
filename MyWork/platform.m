function varargout = platform(varargin)
% PLATFORM MATLAB code for platform.fig
%      PLATFORM, by itself, creates a new PLATFORM or raises the existing
%      singleton*.
%
%      H = PLATFORM returns the handle to a new PLATFORM or the handle to
%      the existing singleton*.
%
%      PLATFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATFORM.M with the given input arguments.
%
%      PLATFORM('Property','Value',...) creates a new PLATFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before platform_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to platform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help platform

% Last Modified by GUIDE v2.5 17-Apr-2015 18:40:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @platform_OpeningFcn, ...
                   'gui_OutputFcn',  @platform_OutputFcn, ...
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


% --- Executes just before platform is made visible.
function platform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to platform (see VARARGIN)

% Choose default command line output for platform
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes platform wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = platform_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function openfile_Callback(hObject, eventdata, handles)
% hObject    handle to openfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Filename,Pathname]=uigetfile({'*.txt'},'Please choose the File:');
%disp(Filename);
if Filename ~= 0
    Filename = strrep(Filename, '.txt', '');
    set(handles.accession, 'String', Filename);
end

% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)
% hObject    handle to submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GEO_DATA;

set(handles.titleShow,'String','');
set(handles.pubmedIdShow,'String','');
set(handles.summaryShow,'String','');
set(handles.countOfSample,'String','');
set(handles.SourceNameList,'String','');
set(handles.SourceNameList,'Value',1);
set(handles.CharacteristicsList,'String','');
set(handles.CharacteristicsList,'Value',1);
set(handles.BothList,'String','');
set(handles.BothList,'Value',1);

%%%%    bagin:  read the GSE file and get the Data
name = get(handles.accession,'String');
if(isempty(name))
    errordlg('Please Input the GSE name!','ERROR');
    return;
else
    filename = [name,'.txt'];
end

if exist(filename,'file')==2
    hReadGSEFile = msgbox('The Operation is under way...');
    GEO_DATA = geoseriesread(filename);
    close(hReadGSEFile);
    msgbox(['The information of GSE file ',filename,' has been shown successfully!']);
else
    try
        hDownloadHint = msgbox('It is going to download, since there is No such file in Your Computer,','Hint');
        hDownloadGSEFile = msgbox('The File is Dowloading...');
        getgeodata(name,'ToFile',filename);
        close(hDownloadGSEFile);
    catch
        close(hDownloadHint);
        close(hDownloadGSEFile);
        errordlg('There is no such a GSE file exist in the Database, please check your input is correct!','ERROR');
        return;
    end
    
    if(exist(filename,'file')==2)
        msgbox('Download the file Success!');
    else
        msgbox('Download Fail, Please try again!');
        return ;
    end
    hReadGSEFile = msgbox('The Operation is under way...');
    GEO_DATA = geoseriesread(filename);
    close(hReadGSEFile);
end
headSeries = GEO_DATA.Header.Series;
setappdata(0, 'headSeries', headSeries);
headSamples = GEO_DATA.Header.Samples;
setappdata(0, 'headSamples', headSamples);
gseMatrixData = GEO_DATA.Data;
setappdata(0, 'gseMatrixData', gseMatrixData);
%disp(class(headSeries));
disp('Series:');
disp(headSeries);
disp('Samples:');
disp(headSamples);
%%%%    end: read the GSE file and get the Data

%%%%    begin: show the essential information
if isfield(headSeries,'title')
    set(handles.titleShow, 'String', headSeries.title);
else
    set(handles.titleShow, 'String', 'non-existent field title');
end
if isfield(headSeries, 'pubmed_id')
    set(handles.pubmedIdShow, 'String', headSeries.pubmed_id);
else
    set(handles.pubmedIdShow, 'String', 'non-existent field title');
end
if isfield(headSeries, 'summary')
   set(handles.summaryShow, 'String', headSeries.summary);
else
    set(handles.summaryShow, 'String', 'non-existent field title');
end
if isfield(headSeries, 'platform_id')
    disp(headSeries.platform_id);
end
%show the count of samples
sizenum=size(headSamples.title,2);
set(handles.countOfSample, 'String', num2str(sizenum)); % set count of samples
%disp(headSamples.characteristics_ch1);
%set(handles.SourceNameList, 'String', headInfo);
%disp(unique(GEO_DATA.Header.Samples.source_name_ch1));
disp(headSamples.characteristics_ch1(:,1));
%%%%    end:    show the essential information

%%%%    begin:  set the value of the list (sourceName,characteristics,GSM)
set(handles.SourceNameList, 'String', unique(headSamples.source_name_ch1));
set(handles.CharacteristicsList, 'String', unique(headSamples.characteristics_ch1(1,:)));
sourceNameStr = get(handles.SourceNameList, 'String');
sourceNameValue = get(handles.SourceNameList,'Value');
selectSNStr = sourceNameStr(sourceNameValue);
stromaldxSN = strcmpi(selectSNStr(1), GEO_DATA.Header.Samples.source_name_ch1);
for i=1:size(sourceNameValue,2)
    stromaldxSNTemp = strcmpi(selectSNStr(i), GEO_DATA.Header.Samples.source_name_ch1);
    stromaldxSN = bitor(stromaldxSN, stromaldxSNTemp);
end

charStr = get(handles.CharacteristicsList, 'String');
charValue = get(handles.CharacteristicsList,'Value');
selectCharStr = charStr(charValue);
stromaldxChar = strcmpi(selectCharStr(1), GEO_DATA.Header.Samples.characteristics_ch1(1,:));
for i=1:size(charValue,2)
    stromaldxCharTemp = strcmpi(selectCharStr(i), GEO_DATA.Header.Samples.characteristics_ch1(1,:));
    stromaldxChar = bitor(stromaldxChar, stromaldxCharTemp);
end
selectColumn = bitand(stromaldxSN, stromaldxChar);
stromaData = GEO_DATA.Data(:,selectColumn);
setappdata(0, 'selectGSEMatrixData', stromaData);
sData = GEO_DATA.Header.Samples.title(:,selectColumn);
colnames = strcat(stromaData.colnames,sData);
set(handles.BothList,'String',colnames);
%%%    end:    set the value of the list (sourceName,characteristics,GSM)
guidata(hObject,handles);

function accession_Callback(hObject, eventdata, handles)
% hObject    handle to accession (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accession as text
%        str2double(get(hObject,'String')) returns contents of accession as a double


% --- Executes during object creation, after setting all properties.
function accession_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accession (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to HeadInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HeadInfo as text
%        str2double(get(hObject,'String')) returns contents of HeadInfo as a double


% --- Executes during object creation, after setting all properties.
function HeadInfo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HeadInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in SourceName.
function SourceName_Callback(hObject, eventdata, handles)
% hObject    handle to SourceName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on selection change in SourceNameList.
function SourceNameList_Callback(hObject, eventdata, handles)
% hObject    handle to SourceNameList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SourceNameList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SourceNameList
global GEO_DATA;
sourceNameStr = get(handles.SourceNameList, 'String');
sourceNameValue = get(handles.SourceNameList,'Value');
selectSNStr = sourceNameStr(sourceNameValue);
stromaldxSN = strcmpi(selectSNStr(1), GEO_DATA.Header.Samples.source_name_ch1);
for i=1:size(sourceNameValue,2)
    stromaldxSNTemp = strcmpi(selectSNStr(i), GEO_DATA.Header.Samples.source_name_ch1);
    stromaldxSN = bitor(stromaldxSN, stromaldxSNTemp);
end

charStr = get(handles.CharacteristicsList, 'String');
charValue = get(handles.CharacteristicsList,'Value');
selectCharStr = charStr(charValue);
stromaldxChar = strcmpi(selectCharStr(1), GEO_DATA.Header.Samples.characteristics_ch1(1,:));
for i=1:size(charValue,2)
    stromaldxCharTemp = strcmpi(selectCharStr(i), GEO_DATA.Header.Samples.characteristics_ch1(1,:));
    stromaldxChar = bitor(stromaldxChar, stromaldxCharTemp);
end
selectColumn = bitand(stromaldxSN, stromaldxChar);
% disp('sourcename:');
% disp(stromaldxSN);
% disp('char:');
% disp(stromaldxChar);
% disp('and:');
% disp(selectColumn);
stromaData = GEO_DATA.Data(:,selectColumn);
sData = GEO_DATA.Header.Samples.title(:,selectColumn);
colnames = strcat(stromaData.colnames,sData);
set(handles.BothList,'String',colnames);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function SourceNameList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SourceNameList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.accession,'String','');
set(handles.titleShow,'String','');
set(handles.pubmedIdShow,'String','');
set(handles.summaryShow,'String','');
set(handles.countOfSample,'String','');
set(handles.SourceNameList,'String','');
set(handles.CharacteristicsList,'String','');
set(handles.BothList,'String','');
clear all;

% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
% hObject    handle to Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('Are you sure all of the information is correct and continue the next operation?','','Yes','No','Yes');  
 
if strcmp(choice, 'Yes')
    try
        topNApp = inputdlg('Please input how many lines do you want to calculate(0 represents all lines ):','TopN',1,{'1000'}); 
        if isempty(topNApp)||isequal(cell2mat( topNApp),'0')
            topNApp = {'+Inf'};
        end
        setappdata(0, 'topNApp', topNApp);
%        calculateProcess();
        screenGene();
    catch
        errordlg('Please check the gse information!');
    end
else
    return;
end


function titleShow_Callback(hObject, eventdata, handles)
% hObject    handle to titleShow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of titleShow as text
%        str2double(get(hObject,'String')) returns contents of titleShow as a double


% --- Executes during object creation, after setting all properties.
function titleShow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to titleShow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pubmedIdShow_Callback(hObject, eventdata, handles)
% hObject    handle to pubmedIdShow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pubmedIdShow as text
%        str2double(get(hObject,'String')) returns contents of pubmedIdShow as a double


% --- Executes during object creation, after setting all properties.
function pubmedIdShow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pubmedIdShow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function summaryShow_Callback(hObject, eventdata, handles)
% hObject    handle to summaryShow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of summaryShow as text
%        str2double(get(hObject,'String')) returns contents of summaryShow as a double


% --- Executes during object creation, after setting all properties.
function summaryShow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to summaryShow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function countOfSample_Callback(hObject, eventdata, handles)
% hObject    handle to countOfSample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of countOfSample as text
%        str2double(get(hObject,'String')) returns contents of countOfSample as a double


% --- Executes during object creation, after setting all properties.
function countOfSample_CreateFcn(hObject, eventdata, handles)
% hObject    handle to countOfSample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in CharacteristicsList.
function CharacteristicsList_Callback(hObject, eventdata, handles)
% hObject    handle to CharacteristicsList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CharacteristicsList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CharacteristicsList

global GEO_DATA;
sourceNameStr = get(handles.SourceNameList, 'String');
sourceNameValue = get(handles.SourceNameList,'Value');
selectSNStr = sourceNameStr(sourceNameValue);
stromaldxSN = strcmpi(selectSNStr(1), GEO_DATA.Header.Samples.source_name_ch1);
for i=1:size(sourceNameValue,2)
    stromaldxSNTemp = strcmpi(selectSNStr(i), GEO_DATA.Header.Samples.source_name_ch1);
    stromaldxSN = bitor(stromaldxSN, stromaldxSNTemp);
end

charStr = get(handles.CharacteristicsList, 'String');
charValue = get(handles.CharacteristicsList,'Value');
selectCharStr = charStr(charValue);
stromaldxChar = strcmpi(selectCharStr(1), GEO_DATA.Header.Samples.characteristics_ch1(1,:));
for i=1:size(charValue,2)
    stromaldxCharTemp = strcmpi(selectCharStr(i), GEO_DATA.Header.Samples.characteristics_ch1(1,:));
    stromaldxChar = bitor(stromaldxChar, stromaldxCharTemp);
end
selectColumn = bitand(stromaldxSN, stromaldxChar);
% disp('sourcename:');
% disp(stromaldxSN);
% disp('char:');
% disp(stromaldxChar);
% disp('and:');
% disp(selectColumn);
stromaData = GEO_DATA.Data(:,selectColumn);
sData = GEO_DATA.Header.Samples.title(:,selectColumn);
colnames = strcat(stromaData.colnames,sData);
set(handles.BothList,'String',colnames);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function CharacteristicsList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CharacteristicsList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in BothList.
function BothList_Callback(hObject, eventdata, handles)
% hObject    handle to BothList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BothList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BothList


% --- Executes during object creation, after setting all properties.
function BothList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BothList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Characteristics.
function Characteristics_Callback(hObject, eventdata, handles)
% hObject    handle to Characteristics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in SelectBoth.
function SelectBoth_Callback(hObject, eventdata, handles)
% hObject    handle to SelectBoth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GEO_DATA;
stromaldx1=zeros(1,size(GEO_DATA.Header.Samples.title,2));
stromaldx2=zeros(1,size(GEO_DATA.Header.Samples.title,2));
for i=1:size(handles.sourceValue,2)
    s1=strcmpi(handles.sampleSource{handles.sourceValue(i)},GEO_DATA.Header.Samples.source_name_ch1);
    %
    stromaldx1=bitor(stromaldx1,s1);
end
for i=1:size(handles.characterValue,2)
    s2=strcmpi(handles.sampleCharacter{handles.characterValue(i)},GEO_DATA.Header.Samples.characteristics_ch1(1,:));
    stromaldx2=bitor(stromaldx2,s2);
end
%
stromaldx3=bitand(stromaldx1,stromaldx2);
stromaldx3=logical(stromaldx3);
stromaData=GEO_DATA.Data(:,stromaldx3);
sData=GEO_DATA.Header.Samples.title(:,stromaldx3);
columnNames=strcat(stromaData.colnames,sData);
set(handles.BothList,'String',columnNames);
guidata(hObject,handles);


% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
clear all;


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function HelpItem_Callback(hObject, eventdata, handles)
% hObject    handle to HelpItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%msgbox({'(1) Pease input the correct GSE code or you also can Open a GSE file with .txt format.Then you can click Submit to show the information about the GSE.';
%    '(2) Select the group of GSM by choose the SourceName and Characteristics,the selected GSM will show in the Selected listbox.If you identify the information ,you can click Next.If there is some wrong?you can click Reset and repeat the first step.'});
helpdlg({'(1) Please input the correct GSE code or you also can Open a GSE file with .txt format.';
    '(2) Select the group of GSM by choose the SourceName and Characteristics,the selected GSM will show in the Selected listbox.';
    '(3)Follow the steps to screen the Gene.';
    '(4)Follow the steps to calculate and then save the result.'});

% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg('Version:  0.1.0');
