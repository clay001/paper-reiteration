function varargout = SingCellNetGUI(varargin)
% SINGCELLNETGUI MATLAB code for SingCellNetGUI.fig
%      SINGCELLNETGUI, by itself, creates a new SINGCELLNETGUI or raises the existing
%      singleton*.
%
%      H = SINGCELLNETGUI returns the handle to a new SINGCELLNETGUI or the handle to
%      the existing singleton*.
%
%      SINGCELLNETGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINGCELLNETGUI.M with the given input arguments.
%
%      SINGCELLNETGUI('Property','Value',...) creates a new SINGCELLNETGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SingCellNetGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SingCellNetGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SingCellNetGUI

% Last Modified by GUIDE v2.5 09-Sep-2016 18:31:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SingCellNetGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SingCellNetGUI_OutputFcn, ...
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


% --- Executes just before SingCellNetGUI is made visible.
function SingCellNetGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SingCellNetGUI (see VARARGIN)

% Choose default command line output for SingCellNetGUI
handles.output = hObject;

% Update handles structure
initParameter(hObject, eventdata, handles)
guidata(hObject, handles);
% UIWAIT makes SingCellNetGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SingCellNetGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function EditExpFile_Callback(hObject, eventdata, handles)
% hObject    handle to EditExpFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditExpFile as text
%        str2double(get(hObject,'String')) returns contents of EditExpFile as a double


% --- Executes during object creation, after setting all properties.
function EditExpFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditExpFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditBenchmarkNet_Callback(hObject, eventdata, handles)
% hObject    handle to EditBenchmarkNet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditBenchmarkNet as text
%        str2double(get(hObject,'String')) returns contents of EditBenchmarkNet as a double


% --- Executes during object creation, after setting all properties.
function EditBenchmarkNet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditBenchmarkNet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OpenExpFile.
function OpenExpFile_Callback(hObject, eventdata, handles)
% hObject    handle to OpenExpFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ExpFileName
[FileName,PathName,~] = uigetfile('*.*', 'Please select Benchmark Network');
% if cancel selection
if FileName == 0
    return
end
ExpFileName = [PathName FileName];
set(handles.EditExpFile, 'string', FileName)



% --- Executes on button press in OpenBenchmarkNet.
function OpenBenchmarkNet_Callback(hObject, eventdata, handles)
% hObject    handle to OpenBenchmarkNet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global BenchmarkNetFileName
[FileName,PathName,~] = uigetfile('*.*', 'Please select Benchmark Network');
% if cancel selection
if FileName == 0
    return
end
BenchmarkNetFileName = [PathName FileName];
set(handles.EditBenchmarkNet, 'string', FileName)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Running SingCellNet');
Main();



function EditPopulationSize_Callback(hObject, eventdata, handles)
% hObject    handle to EditPopulationSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditPopulationSize as text
%        str2double(get(hObject,'String')) returns contents of EditPopulationSize as a double
global populationSize
populationSize = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function EditPopulationSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditPopulationSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditNTop_Callback(hObject, eventdata, handles)
% hObject    handle to EditNTop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditNTop as text
%        str2double(get(hObject,'String')) returns contents of EditNTop as a double
global ntop
ntop = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function EditNTop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditNTop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditMutationRate_Callback(hObject, eventdata, handles)
% hObject    handle to EditMutationRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditMutationRate as text
%        str2double(get(hObject,'String')) returns contents of EditMutationRate as a double
global prob_mut;
prob_mut = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function EditMutationRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditMutationRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditPermuPerChrom_Callback(hObject, eventdata, handles)
% hObject    handle to EditPermuPerChrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditPermuPerChrom as text
%        str2double(get(hObject,'String')) returns contents of EditPermuPerChrom as a double
global num_mut_per_genome
num_mut_per_genome = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function EditPermuPerChrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditPermuPerChrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditITTimes_Callback(hObject, eventdata, handles)
% hObject    handle to EditITTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditITTimes as text
%        str2double(get(hObject,'String')) returns contents of EditITTimes as a double
global num_GA;
num_GA = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function EditITTimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditITTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function initParameter(hObject, eventdata, handles)
global num_gene;
global num_celltype;
%global typeNum;
global Kmax; % max inputs per gene
global ntimes;  % for PBN
global GeneRelation;
%global signalType;
ntimes = 100;
global prob_mut;
global ntop;
global num_GA;
global num_mut_per_genome;
global populationSize;
populationSize = 1000;
prob_mut = 0.01;
ntop = 100;
num_GA = 10;
num_mut_per_genome = 1;
set(handles.EditITTimes, 'string', num2str(num_GA));
set(handles.EditMutationRate, 'string', num2str(prob_mut));
set(handles.EditNTop, 'string', num2str(ntop));
set(handles.EditPopulationSize, 'string', num2str(populationSize));
set(handles.EditPermuPerChrom, 'string', num2str(num_mut_per_genome));


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function EditScoreMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to EditScoreMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditScoreMatrix as text
%        str2double(get(hObject,'String')) returns contents of EditScoreMatrix as a double


% --- Executes during object creation, after setting all properties.
function EditScoreMatrix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditScoreMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ScoreMatrix.
function ScoreMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to ScoreMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scorematrix
[FileName,PathName,~] = uigetfile('*.*', 'Please select Score matrix file');
% if cancel selection
if FileName == 0
    return
end
wholeFileName = [PathName FileName];
set(handles.EditScoreMatrix, 'string', FileName)
scorematrix = load(wholeFileName);



function EditGeneRelation_Callback(hObject, eventdata, handles)
% hObject    handle to EditGeneRelation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditGeneRelation as text
%        str2double(get(hObject,'String')) returns contents of EditGeneRelation as a double
global GeneRelation;
GeneRelation=str2num(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function EditGeneRelation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditGeneRelation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
