

function varargout = LogisticBifurcationDiagram(varargin)
% LOGISTICBIFURCATIONDIAGRAM MATLAB code for LogisticBifurcationDiagram.fig
%
%**************************************************************************
%**************************************************************************
%
% By:       Michael J. Richardson, 2010
%           Department of Psychology
%           University of Cincinnati
%           michael.richardson@uc.edu
%
%**************************************************************************
%**************************************************************************
%
%      LOGISTICBIFURCATIONDIAGRAM, by itself, creates a new LOGISTICBIFURCATIONDIAGRAM or raises the existing
%      singleton*.
%
%      H = LOGISTICBIFURCATIONDIAGRAM returns the handle to a new LOGISTICBIFURCATIONDIAGRAM or the handle to
%      the existing singleton*.
%
%      LOGISTICBIFURCATIONDIAGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOGISTICBIFURCATIONDIAGRAM.M with the given input arguments.
%
%      LOGISTICBIFURCATIONDIAGRAM('Property','Value',...) creates a new LOGISTICBIFURCATIONDIAGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LogisticBifurcationDiagram_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LogisticBifurcationDiagram_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LogisticBifurcationDiagram

% Last Modified by GUIDE v2.5 09-Jun-2015 09:19:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LogisticBifurcationDiagram_OpeningFcn, ...
                   'gui_OutputFcn',  @LogisticBifurcationDiagram_OutputFcn, ...
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

% --- Executes just before LogisticBifurcationDiagram is made visible.
function LogisticBifurcationDiagram_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LogisticBifurcationDiagram (see VARARGIN)

% Choose default command line output for LogisticBifurcationDiagram
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using LogisticBifurcationDiagram.
if strcmp(get(hObject,'Visible'),'off')
    
    axes(handles.axes1);
    cla;

    Rmin = str2double(get(handles.Rparam, 'String'));
    Rmax = 4;

    plot(0,0, 'ok', 'markersize', 1);
    xlabel('R');
    ylabel('Asymptotic x(t)');
    xlim([Rmin Rmax]);
    ylim([0 1]);

end

% UIWAIT makes LogisticBifurcationDiagram wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LogisticBifurcationDiagram_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pbPlay.
function pbPlay_Callback(hObject, eventdata, handles)
% hObject    handle to pbPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pbPlay, 'Enable', 'Off');
axes(handles.axes1);
cla;

Rmin = str2double(get(handles.Rparam, 'String'));
Rmax = 4;
Rstep = str2double(get(handles.Rstepsize, 'String'));

hold on;
xlabel('R');
ylabel('Asymptotic x(t)');
xlim([Rmin Rmax]);
ylim([0 1]);

for R=Rmin:Rstep:Rmax
    x = zeros(2000, 1);
    x(1) = .1;

    for i=2:2000
        x(i) = R*x(i-1)*(1-x(i-1));
    end

    x_asym = unique(x(1601:2000));
    plot(R,x_asym(:,1), 'ok', 'MarkerSize', 1);
    pause(.01);
end
hold off;
set(handles.pbPlay, 'Enable', 'On');


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles) %#ok<*DEFNU,*INUSL>
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)



function Rparam_Callback(hObject, eventdata, handles)
% hObject    handle to Rparam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject,'String'));
if temp < .1
    set(hObject, 'String', '.1');
end

if temp > 3.9
    set(hObject, 'String', '3.9');
end


% --- Executes during object creation, after setting all properties.
function Rparam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rparam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Rstepsize_Callback(hObject, eventdata, handles)
% hObject    handle to Rstepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject,'String'));
if temp < .005
    set(hObject, 'String', '.005');
end

if temp > .05
    set(hObject, 'String', '.05');
end


% --- Executes during object creation, after setting all properties.
function Rstepsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rstepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
