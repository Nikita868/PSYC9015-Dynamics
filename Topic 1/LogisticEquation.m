function varargout = LogisticEquation(varargin)
% LOGISTICEQUATION MATLAB code for LogisticEquation.fig
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
%      LOGISTICEQUATION, by itself, creates a new LOGISTICEQUATION or raises the existing
%      singleton*.
%
%      H = LOGISTICEQUATION returns the handle to a new LOGISTICEQUATION or the handle to
%      the existing singleton*.
%
%      LOGISTICEQUATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOGISTICEQUATION.M with the given input arguments.
%
%      LOGISTICEQUATION('Property','Value',...) creates a new LOGISTICEQUATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LogisticEquation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LogisticEquation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LogisticEquation

% Last Modified by GUIDE v2.5 09-Jun-2015 09:21:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LogisticEquation_OpeningFcn, ...
                   'gui_OutputFcn',  @LogisticEquation_OutputFcn, ...
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

% --- Executes just before LogisticEquation is made visible.
function LogisticEquation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LogisticEquation (see VARARGIN)

% Choose default command line output for LogisticEquation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using LogisticEquation.
if strcmp(get(hObject,'Visible'),'off')
    
    X_initial = str2double(get(handles.X_ini, 'String'));
    R = str2double(get(handles.Rparam, 'String'));
    iterations = str2double(get(handles.NumIterations, 'String'));
    
    x = 0:.001:1;
    x = transpose(x);

    % Initialize function array (fx)
    fx = zeros(length(x),1);

    % Calculate function for specific R value
    for i=1:length(x)
        fx(i) = R*x(i)*(1-x(i));
    end
    
    % Initialize data array for initial value numerical solution (xt)
    xt = zeros(iterations, 1);
    xt(1) = X_initial;
    
    axes(handles.axes1);
    plot(x,x, 'b-', x,fx, '-k'); %plot x vs. x
    xlabel('x(t)');
    ylabel('x(t+1)');
    
    axes(handles.axes2);
    plot(xt(1), '-ok');
    xlabel('t');
    ylabel('x');
    xlim([1 iterations]);
    ylim([0 1]);
    
end

% UIWAIT makes LogisticEquation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LogisticEquation_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton1, 'Enable', 'Off');
axes(handles.axes2);
cla;
axes(handles.axes1);
cla;

%popup_sel_index = get(handles.popupmenu1, 'Value');

X_initial = str2double(get(handles.X_ini, 'String'));
R = str2double(get(handles.Rparam, 'String'));
iterations = str2double(get(handles.NumIterations, 'String'));
animation_speed = str2double(get(handles.AnimationSpeed, 'String'));

% Initialize array of possible x values for function (x = 0 to 1);
x = 0:.001:1;
x = transpose(x);

% Initialize function array (fx)
fx = zeros(length(x),1);

% Calculate function for specific R value
for i=1:length(x)
    fx(i) = R*x(i)*(1-x(i));
end

% Initialize data array for initial value numerical solution (xt)
xt = zeros(iterations, 1);
xt(1) = X_initial;

% Calculate numeric solution specific R value and initial condition (X_in)
for i=2:iterations
    xt(i) = R*xt(i-1)*(1-xt(i-1));
end

axes(handles.axes1);
hold on;
plot(x,x, 'b-', x,fx, '-k'); %plot x vs. x
%plot solution using cobweb method
for i=1:iterations-1
    if i==1
        plot([xt(i),xt(i)],[0, xt(i+1)], '-r');
    else
        plot([xt(i-1),xt(i)],[xt(i),xt(i)], '-r');
        plot([xt(i),xt(i)],[xt(i),xt(i+1)], '-r');
    end
    pause(.05*animation_speed); % animation speed
end
xlabel('x(t)');
ylabel('x(t+1)');
hold off;

axes(handles.axes2);
plot(xt, '-ok');
xlabel('t');
ylabel('x');
xlim([1 iterations]);
ylim([0 1]);
set(handles.pushbutton1, 'Enable', 'On');




% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
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


function X_ini_Callback(hObject, eventdata, handles)
% hObject    handle to X_ini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject,'String'));
if temp < .01
    set(hObject, 'String', '.01');
end

if temp > .99
    set(hObject, 'String', '.99');
end


% --- Executes during object creation, after setting all properties.
function X_ini_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_ini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumIterations_Callback(hObject, eventdata, handles)
% hObject    handle to NumIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject,'String'));
temp = round(temp);
set(hObject, 'String', num2str(temp));
if temp < 1
    set(hObject, 'String', '1');
end

if temp > 100
    set(hObject, 'String', '100');
end


% --- Executes during object creation, after setting all properties.
function NumIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AnimationSpeed_Callback(hObject, eventdata, handles)
% hObject    handle to AnimationSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject,'String'));
temp = round(temp);
set(hObject, 'String', num2str(temp));
if temp < 1
    set(hObject, 'String', '1');
end

if temp > 20
    set(hObject, 'String', '20');
end


% --- Executes during object creation, after setting all properties.
function AnimationSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AnimationSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Rparam_Callback(hObject, eventdata, handles)
% hObject    handle to Rparam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject,'String'));
if temp < .1
    set(hObject, 'String', '.1');
end

if temp > 3.99
    set(hObject, 'String', '3.99');
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
