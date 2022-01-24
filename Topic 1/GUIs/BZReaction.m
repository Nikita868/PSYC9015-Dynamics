function varargout = BZReaction(varargin)
% BZREACTION MATLAB code for BZReaction.fig
%      BZREACTION, by itself, creates a new BZREACTION or raises the existing
%      singleton*.
%
%      H = BZREACTION returns the handle to a new BZREACTION or the handle to
%      the existing singleton*.
%
%      BZREACTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BZREACTION.M with the given input arguments.
%
%      BZREACTION('Property','Value',...) creates a new BZREACTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BZReaction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BZReaction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BZReaction

% Last Modified by GUIDE v2.5 08-Jun-2015 22:54:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BZReaction_OpeningFcn, ...
                   'gui_OutputFcn',  @BZReaction_OutputFcn, ...
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


% --- Executes just before BZReaction is made visible.
function BZReaction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BZReaction (see VARARGIN)

% Choose default command line output for BZReaction
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BZReaction wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BZReaction_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edGridSize_Callback(hObject, eventdata, handles)
% hObject    handle to edGridSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject,'String'));
temp = round(temp);
set(hObject, 'String', num2str(temp));
if temp < 50
    set(hObject, 'String', '50');
end

if temp > 400
    set(hObject, 'String', '400');
end


% --- Executes during object creation, after setting all properties.
function edGridSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edGridSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edNumIterations_Callback(hObject, eventdata, handles)
% hObject    handle to edNumIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject,'String'));
temp = round(temp);
set(hObject, 'String', num2str(temp));
if temp < 10
    set(hObject, 'String', '10');
end

if temp > 500
    set(hObject, 'String', '500');
end


% --- Executes during object creation, after setting all properties.
function edNumIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edNumIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbSimulate.
function pbSimulate_Callback(hObject, eventdata, handles)
% hObject    handle to pbSimulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BZ_Simulation(hObject, eventdata, handles);


function edAlpha_Callback(hObject, eventdata, handles)
% hObject    handle to edAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject,'String'));
if temp < .5
    set(hObject, 'String', '.5');
end

if temp > 2
    set(hObject, 'String', '2');
end


% --- Executes during object creation, after setting all properties.
function edAlpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edBeta_Callback(hObject, eventdata, handles)
% hObject    handle to edBeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject,'String'));
if temp < .5
    set(hObject, 'String', '.5');
end

if temp > 2
    set(hObject, 'String', '2');
end


% --- Executes during object creation, after setting all properties.
function edBeta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edBeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edGamma_Callback(hObject, eventdata, handles)
% hObject    handle to edGamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject,'String'));
if temp < .5
    set(hObject, 'String', '.5');
end

if temp > 2
    set(hObject, 'String', '2');
end

% --- Executes during object creation, after setting all properties.
function edGamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edGamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function BZ_Simulation(hObject, eventdata, handles)
%**************************************************************************
% function BZ_Simulation(alpha, beta, gamma, gridsize, itime)
%  
% Description: The BZ reaction can be reduced to three autocatalytic 
% equations (reactions), where A, B and C represent the three reactants. 
% 
%        A + B ? 2A,    B + C ? 2B,    C + A ? 2C
% 
% Such that the quantity of A, B and C as time progresses can be written
% as:
%   at+1 = at + at(alpha*bt-gamma*ct)
%   bt+1 = bt + bt(gamma*ct- beta*at)
%   ct+1 = ct + ct(beta*at- alpha*bt)
% 
% where the parameters alpha, beta, gamma determine the rate of reaction.
%
% Input Parameters (set below):
%            alpha   : paramter
%             beta   : paramter
%            gamma   : paramter
%         gridsize   : size of image grid (number of cells)
%            itime   : number of iterations (e.g., 200)
% 
% % Syntax:  
%           BZ_Simulation()
%
% By:       Michael J. Richardson, 2009
%           Department of Psychology
%           University of Cincinnati
%           michael.richardson@uc.edu
%
%**************************************************************************
%**************************************************************************

% disbale edit boxes
set(handles.pbSimulate,'Enable','Off');
set(handles.edAlpha,'Enable','Off');
set(handles.edBeta,'Enable','Off');
set(handles.edGamma,'Enable','Off');
set(handles.edGridSize,'Enable','Off');
set(handles.edNumIterations,'Enable','Off');


% Input Parameters
alpha = str2double(get(handles.edAlpha,'String'));
beta = str2double(get(handles.edBeta,'String'));
gamma = str2double(get(handles.edGamma,'String'));
gridsize = str2double(get(handles.edGridSize,'String'));
grid_width = gridsize;
grid_height = gridsize;
itime = str2double(get(handles.edNumIterations,'String'));
p = 1;
q = 2;


a = zeros(grid_width,grid_height,2);
b = zeros(grid_width,grid_height,2);
c = zeros(grid_width,grid_height,2);
mBZ = zeros(gridsize);

for x=1:grid_width
    for y=1:grid_height
        a(x,y,p) = rand();
        b(x,y,p) = rand();
        c(x,y,p) = rand();
    end
end

axes(handles.axes1);
cla;
axes(handles.axes1);
for t=1:itime
    grid = zeros(grid_width, grid_height);
    
    for x=0:grid_width-1
        for y=0:grid_height-1
            
            c_a = 0;
            c_b = 0;
            c_c = 0;

            for i=x-1:x+1
                for j=y-1:y+1
                    c_a = c_a+a(mod(i+grid_width, grid_width)+1, mod(j+grid_height,grid_height)+1, p);
                    c_b = c_b+b(mod(i+grid_width, grid_width)+1, mod(j+grid_height,grid_height)+1, p);
                    c_c = c_c+c(mod(i+grid_width, grid_width)+1, mod(j+grid_height,grid_height)+1, p);
                end
            end

            c_a = c_a/9.0;
            c_b = c_b/9.0;
            c_c = c_c/9.0;

            a(x+1,y+1,q) = (c_a + (c_a*(alpha*c_b - gamma*c_c)));
            b(x+1,y+1,q) = (c_b + (c_b*(gamma*c_c - beta*c_a)));
            c(x+1,y+1,q) = (c_c + (c_c*(beta*c_a - alpha*c_b)));
            
            if (a(x+1,y+1,q) < .001) 
                a(x+1,y+1,q) = .001; 
            end
            if (a(x+1,y+1,q) > 255)
                a(x+1,y+1,q) = 255;
            end
            
             if (b(x+1,y+1,q) < .001) 
                b(x+1,y+1,q) = .001; 
            end
            if (b(x+1,y+1,q) > 255)
                b(x+1,y+1,q) = 255;
            end
          
            if (c(x+1,y+1,q) < .001) 
                c(x+1,y+1,q) = .001; 
            end
            
            if (c(x+1,y+1,q) > 255)
                c(x+1,y+1,q) = 255;
            end
            

            grid(x+1,y+1) = round(a(x+1,y+1,q));
        end
    end

    mBZ(t) = grid(round(gridsize/2), round(gridsize/2));
    image(grid);
    title(['Iteration ' num2str(t)]);
    drawnow;
    
    if p == 1
        p = 2; 
        q = 1;
    else
        p = 1;
        q = 2;
    end
end

set(handles.pbSimulate,'Enable','On');
set(handles.edAlpha,'Enable','On');
set(handles.edBeta,'Enable','On');
set(handles.edGamma,'Enable','On');
set(handles.edGridSize,'Enable','On');
set(handles.edNumIterations,'Enable','On');

return
