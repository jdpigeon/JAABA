function varargout = JAABA_plot(varargin)
%JAABA_PLOT M-file for JAABA_plot.fig
%      JAABA_PLOT, by itself, creates a new JAABA_PLOT or raises the existing
%      singleton*.
%
%      H = JAABA_PLOT returns the handle to a new JAABA_PLOT or the handle to
%      the existing singleton*.
%
%      JAABA_PLOT('Property','Value',...) creates a new JAABA_PLOT using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to JAABA_plot_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      JAABA_PLOT('CALLBACK') and JAABA_PLOT('CALLBACK',hObject,...) call the
%      local function named CALLBACK in JAABA_PLOT.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help JAABA_plot

% Last Modified by GUIDE v2.5 30-Jul-2012 10:59:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @JAABA_plot_OpeningFcn, ...
                   'gui_OutputFcn',  @JAABA_plot_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% ---
function handles=initialize(handles)

handles.experimentlist={};
handles.experimentvalue=[];
handles.experimentlist2={};
handles.experimentvalue2=[];
handles.behaviors={};
handles.behaviorlist={''};
handles.behaviorvalue=1;
handles.behaviorlogic=1;
handles.behaviorvalue2=1;
handles.features={};
handles.featurelist={''};
handles.featurevalue=1;
handles.individuals=[];
handles.individuallist={'All' 'Male' 'Female'};
handles.individualvalue=1;
handles.individual=1;
handles.sexdata={};
handles.histogram_perwhat=1;
handles.timeseries_timing=1;
handles.timeseries_statistic=1;
handles.timeseries_subtractmean=0;
handles.timeseries_windowradius=10;
handles.timeseries_tight=0;
handles.boutstats=1;
handles.logy=0;
handles.stats=0;
handles.interesting_histograms=[];
handles.interesting_timeseries=[];
set(handles.ExperimentList,'enable','off');
set(handles.ExperimentList2,'enable','off');
set(handles.BehaviorList,'enable','off');
set(handles.BehaviorLogic,'enable','off');
set(handles.BehaviorList2,'enable','off');
set(handles.FeatureList,'enable','off');
set(handles.IndividualList,'enable','off');


% --- Executes just before JAABA_plot is made visible.
function JAABA_plot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

if(exist('matlabpool')==2 && matlabpool('size')==0)
  matlabpool open
end

%keyboard
if(exist('JAABA_plot.mat')==2)
  handles_saved=load('JAABA_plot.mat');
  handles_saved=handles_saved.handles;
  handles.experimentlist=handles_saved.experimentlist;
  handles.experimentvalue=handles_saved.experimentvalue;
  handles.experimentlist2=handles_saved.experimentlist2;
  handles.experimentvalue2=handles_saved.experimentvalue2;
  handles.behaviors=handles_saved.behaviors;
  handles.behaviorlist=handles_saved.behaviorlist;
  handles.behaviorvalue=handles_saved.behaviorvalue;
  handles.behaviorlogic=handles_saved.behaviorlogic;
  handles.behaviorvalue2=handles_saved.behaviorvalue2;
  handles.features=handles_saved.features;
  handles.featurelist=handles_saved.featurelist;
  handles.featurevalue=handles_saved.featurevalue;
  handles.individuals=handles_saved.individuals;
  handles.individuallist=handles_saved.individuallist;
  handles.individualvalue=handles_saved.individualvalue;
  handles.sexdata=handles_saved.sexdata;
  handles.histogram_perwhat=handles_saved.histogram_perwhat;
  handles.timeseries_timing=handles_saved.timeseries_timing;
  handles.timeseries_statistic=handles_saved.timeseries_statistic;
  handles.timeseries_subtractmean=handles_saved.timeseries_subtractmean;
  handles.timeseries_windowradius=handles_saved.timeseries_windowradius;
  handles.timeseries_tight=handles_saved.timeseries_tight;
  handles.boutstats=handles_saved.boutstats;
  handles.logy=handles_saved.logy;
  handles.stats=handles_saved.stats;
  handles.interesting_histograms=handles_saved.interesting_histograms;
  handles.interesting_timeseries=handles_saved.interesting_timeseries;

  set(handles.ExperimentList,'String',handles.experimentlist);
  set(handles.ExperimentList,'Value',handles.experimentvalue);
  set(handles.ExperimentList2,'String',handles.experimentlist2);
  set(handles.ExperimentList2,'Value',handles.experimentvalue2);
  set(handles.BehaviorList,'String',handles.behaviorlist);
  set(handles.BehaviorList,'Value',handles.behaviorvalue);
  set(handles.BehaviorLogic,'Value',handles.behaviorlogic);
  set(handles.BehaviorList2,'String',handles.behaviorlist);
  set(handles.BehaviorList2,'Value',handles.behaviorvalue2);
  set(handles.FeatureList,'String',handles.featurelist);
  set(handles.FeatureList,'Value',handles.featurevalue);
  set(handles.IndividualList,'String',handles.individuallist);
  set(handles.IndividualList,'Value',handles.individualvalue);

  if(length(handles.experimentlist)==0)
    set(handles.ExperimentList,'enable','off');
  end
  if(length(handles.experimentlist2)==0)
    set(handles.ExperimentList2,'enable','off');
  end
  if((length(handles.experimentlist)==0) && (length(handles.experimentlist2)==0))
    set(handles.BehaviorList,'enable','off');
    set(handles.BehaviorLogic,'enable','off');
    set(handles.BehaviorList2,'enable','off');
    set(handles.FeatureList,'enable','off');
    set(handles.IndividualList,'enable','off');
  end
  if(handles.behaviorlogic==1)
    set(handles.BehaviorList2,'enable','off');
  else
    set(handles.BehaviorList2,'enable','on');
  end
  menu_histogram_set(handles.histogram_perwhat);
  switch(handles.timeseries_timing)
    case 1
      MenuTimeSeriesTimingOnset_Callback(hObject, eventdata, handles);
    case 2
      MenuTimeSeriesTimingOffset_Callback(hObject, eventdata, handles);
  end
  menu_timeseries_statistic_set(handles.timeseries_statistic);
  switch(handles.timeseries_subtractmean)
    case 0
      set(handles.MenuTimeSeriesSubtractMean,'Checked','off');
    case 1
      set(handles.MenuTimeSeriesSubtractMean,'Checked','on');
  end
  set(handles.MenuTimeSeriesTight,'Checked','off');
  menu_boutstats_set(handles.boutstats);
  if(handles.logy)   set(handles.LogY, 'backgroundcolor',0.4*[1 1 1]);  end
  if(handles.stats)  set(handles.Stats,'backgroundcolor',0.4*[1 1 1]);  end
else
  handles=initialize(handles);
end

% Choose default command line output for JAABA_plot
handles.output = hObject;

set(hObject,'CloseRequestFcn',@figure_CloseRequestFcn);
set(handles.Table,'CellSelectionCallback',@Interesting_CellSelectionCallback);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes JAABA_plot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

handles=initialize(handles);

set(handles.ExperimentList,'String',handles.experimentlist,'Value',handles.experimentvalue);
set(handles.ExperimentList2,'String',handles.experimentlist2,'Value',handles.experimentvalue2);
set(handles.BehaviorList,'String',handles.behaviorlist);
set(handles.BehaviorLogic,'Value',handles.behaviorlogic);
set(handles.BehaviorList2,'String',handles.behaviorlist);
set(handles.FeatureList,'String',handles.featurelist);
set(handles.IndividualList,'String',handles.individuallist,'Value',handles.individualvalue);

menu_histogram_set(handles.histogram_perwhat);
MenuTimeSeriesTimingOnset_Callback(hObject, eventdata, handles);
menu_timeseries_statistic_set(handles.timeseries_statistic);
set(handles.MenuTimeSeriesSubtractMean,'Checked','off');
set(handles.MenuTimeSeriesTight,'Checked','off');
menu_boutstats_set(handles.boutstats);
set(handles.LogY,'backgroundcolor',get(gcf,'color'));
set(handles.Stats,'backgroundcolor',get(gcf,'color'));

save('JAABA_plot.mat','handles');

guidata(hObject, handles);


% ---
function figure_CloseRequestFcn(hObject, eventdata)

handles=guidata(hObject);
save('JAABA_plot.mat','handles');
delete(hObject);


% --- Outputs from this function are returned to the command line.
function varargout = JAABA_plot_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in UpdatePlot.
function UpdatePlot_Callback(hObject, eventdata, handles)
% hObject    handle to UpdatePlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)


% --- Executes on selection change in FeatureList.
function FeatureList_Callback(hObject, eventdata, handles)
% hObject    handle to FeatureList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FeatureList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FeatureList

handles.featurevalue=get(handles.FeatureList,'Value');
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function FeatureList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FeatureList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in BehaviorList.
function BehaviorList_Callback(hObject, eventdata, handles)
% hObject    handle to BehaviorList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BehaviorList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BehaviorList

handles.behaviorvalue=get(handles.BehaviorList,'Value');
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function BehaviorList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BehaviorList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in BehaviorLogic.
function BehaviorLogic_Callback(hObject, eventdata, handles)
% hObject    handle to BehaviorLogic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BehaviorLogic contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BehaviorLogic

handles.behaviorlogic=get(handles.BehaviorLogic,'Value');
if(handles.behaviorlogic==1)
  set(handles.BehaviorList2,'enable','off');
else
  set(handles.BehaviorList2,'enable','on');
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function BehaviorLogic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BehaviorLogic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in BehaviorList2.
function BehaviorList2_Callback(hObject, eventdata, handles)
% hObject    handle to BehaviorList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BehaviorList2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BehaviorList2


% --- Executes during object creation, after setting all properties.
function BehaviorList2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BehaviorList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExperimentList2.
function ExperimentList2_Callback(hObject, eventdata, handles)
% hObject    handle to ExperimentList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ExperimentList2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExperimentList2

handles.experimentvalue2=get(handles.ExperimentList2,'Value');
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function ExperimentList2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExperimentList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExperimentList.
function ExperimentList_Callback(hObject, eventdata, handles)
% hObject    handle to ExperimentList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ExperimentList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExperimentList

handles.experimentvalue=get(handles.ExperimentList,'Value');
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function ExperimentList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExperimentList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% ---
function ret_val=check_for_diff_and_return_intersection(arg)

if(length(arg)==1)  ret_val=arg{1};  return;  end

flatten=[arg{:}];
anotb=setdiff(flatten,arg{end});
bnota=setdiff(arg{end},flatten);
if(numel(anotb)>0)
  tmp=char(anotb);
  tmp=[tmp repmat(', ',size(tmp,1),1)];
  tmp=reshape(tmp',1,numel(tmp));
  tmp=tmp(1:end-2);
  warning([tmp ' are/is in prior experiments but not new one.  proceeding with intersection.']);
end
if(numel(bnota)>0)
  tmp=char(bnota);
  tmp=[tmp repmat(', ',size(tmp,1),1)];
  tmp=reshape(tmp',1,numel(tmp));
  tmp=tmp(1:end-2);
  warning([tmp ' are/is in new experiment but not prior ones.  proceeding with intersection.']);
end
ret_val=intersect(arg{end},flatten);


% ---
function handles=fillin_individuallist(handles)

tmp=cell(1,3+sum(handles.individuals));
tmp(1:3)={'All' 'Male' 'Female'};
k=4;
for i=1:length(handles.individuals)
  for j=1:handles.individuals(i)
    c='R';  n=i;  if(i>length(handles.experimentlist))  c='B';  n=n-length(handles.experimentlist);  end
    tmp{k}=['Exp #' c num2str(n) ', Indi #' num2str(j)];
    k=k+1;
  end
end
handles.individuallist=tmp;
set(handles.IndividualList,'String',handles.individuallist);


% ---
function experiment_add(hObject,handles,arg)

set(handles.Status,'string','Thinking...');

tmp=uigetdir([],'Select Experiment Directory');
if(tmp==0)  return;  end
if(arg==1)
  handles.experimentlist{end+1}=tmp;
  handles.experimentvalue=length(handles.experimentlist);
  set(handles.ExperimentList,'String',handles.experimentlist);
  set(handles.ExperimentList,'Value',handles.experimentvalue);
  set(handles.ExperimentList,'enable','on');
  ptr=handles.experimentlist;
else
  handles.experimentlist2{end+1}=tmp;
  handles.experimentvalue2=length(handles.experimentlist2);
  set(handles.ExperimentList2,'String',handles.experimentlist2);
  set(handles.ExperimentList2,'Value',handles.experimentvalue2);
  set(handles.ExperimentList2,'enable','on');
  ptr=handles.experimentlist2;
end

set(handles.BehaviorList,'enable','on');
set(handles.BehaviorLogic,'enable','on');
if(handles.behaviorlogic>1)
  set(handles.BehaviorList2,'enable','on');
end
set(handles.FeatureList,'enable','on');
set(handles.IndividualList,'enable','on');

tmp=dir(fullfile(ptr{end},'scores*.mat'));
[handles.behaviors{end+1}{1:length(tmp)}]=deal(tmp.name);
if(arg==1)
  handles.behaviors=...
      handles.behaviors([1:(length(handles.experimentlist)-1) end (end-length(handles.experimentlist2)):(end-1)]);
end
handles.behaviorlist=check_for_diff_and_return_intersection(handles.behaviors);
set(handles.BehaviorList,'String',handles.behaviorlist);
set(handles.BehaviorList2,'String',handles.behaviorlist);

tmp=dir(fullfile(ptr{end},'perframe','*.mat'));
[handles.features{end+1}{1:length(tmp)}]=deal(tmp.name);
if(arg==1)
  handles.features=...
      handles.features([1:(length(handles.experimentlist)-1) end (end-length(handles.experimentlist2)):(end-1)]);
end
handles.featurelist=check_for_diff_and_return_intersection(handles.features);
set(handles.FeatureList,'String',handles.featurelist);

behavior_data=load(fullfile(char(ptr(end)),char(handles.behaviorlist(1))));
handles.individuals(end+1)=length(behavior_data.allScores.t0s);
if(arg==1)
  handles.individuals=...
      handles.individuals([1:(length(handles.experimentlist)-1) end (end-length(handles.experimentlist2)):(end-1)]);
end
handles=fillin_individuallist(handles);

sexdata=load(fullfile(char(ptr(end)),'perframe',...
    char(handles.featurelist(find(strcmp(handles.featurelist,'sex.mat'))))));
for i=1:length(sexdata.data)
  sexdata.data{i}=strcmp(sexdata.data{i},'M');
end
handles.sexdata(end+1)={sexdata.data};
if(arg==1)
  handles.sexdata=...
      handles.sexdata([1:(length(handles.experimentlist)-1) end (end-length(handles.experimentlist2)):(end-1)]);
end

handles.interesting_histograms=[];
handles.interesting_timeseries=[];

guidata(hObject,handles);

set(handles.Status,'string','Ready.');


% --- Executes on button press in ExperimentAdd2.
function ExperimentAdd2_Callback(hObject, eventdata, handles)
% hObject    handle to ExperimentAdd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

experiment_add(hObject,handles,2);


% --- Executes on button press in ExperimentAdd.
function ExperimentAdd_Callback(hObject, eventdata, handles)
% hObject    handle to ExperimentAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

experiment_add(hObject,handles,1);


% ---
function experiment_delete(hObject,handles,idx)

handles.behaviors(idx)=[];
handles.behaviorlist=unique([handles.behaviors{:}]);
handles.behaviorvalue=max(1,min(handles.behaviorvalue,length(handles.behaviorlist)));
handles.behaviorvalue2=max(1,min(handles.behaviorvalue2,length(handles.behaviorlist)));
if(length(handles.behaviorlist)==0)
  handles.behaviorlist={''};
end
set(handles.BehaviorList,'String',handles.behaviorlist);
set(handles.BehaviorList2,'String',handles.behaviorlist);
set(handles.BehaviorList,'Value',handles.behaviorvalue);
set(handles.BehaviorList2,'Value',handles.behaviorvalue2);

handles.features(idx)=[];
handles.featurelist=unique([handles.features{:}]);
handles.featurevalue=max(1,min(handles.featurevalue,length(handles.featurelist)));
if(length(handles.featurelist)==0)
  handles.featurelist={''};
end
set(handles.FeatureList,'String',handles.featurelist);
set(handles.FeatureList,'Value',handles.featurevalue);

handles.individuals(idx)=[];
handles=fillin_individuallist(handles);

handles.sexdata(idx)=[];

handles.interesting_histograms=[];
handles.interesting_timeseries=[];

guidata(hObject,handles);

set(handles.Status,'string','Ready.');


% --- Executes on button press in ExperimentDelete2.
function ExperimentDelete2_Callback(hObject, eventdata, handles)
% hObject    handle to ExperimentDelete2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(length(handles.experimentlist2)==0)  return;  end

set(handles.Status,'string','Thinking...');

idx=get(handles.ExperimentList2,'Value');
handles.experimentlist2(idx)=[];
handles.experimentvalue2=min(handles.experimentvalue2,length(handles.experimentlist2));
handles.experimentvalue2=max(handles.experimentvalue2,1);
if(length(handles.experimentlist2)==0)
  handles.experimentlist2={};
  handles.experimentvalue2=[];
  set(handles.ExperimentList2,'enable','off');
  if(length(handles.experimentlist)==0)
    set(handles.BehaviorList,'enable','off');
    set(handles.BehaviorLogic,'enable','off');
    set(handles.BehaviorList2,'enable','off');
    set(handles.FeatureList,'enable','off');
    set(handles.IndividualList,'enable','off');
  end
end
set(handles.ExperimentList2,'String',handles.experimentlist2);
set(handles.ExperimentList2,'Value',handles.experimentvalue2);

experiment_delete(hObject,handles,idx+length(handles.experimentlist));


% --- Executes on button press in ExperimentDelete.
function ExperimentDelete_Callback(hObject, eventdata, handles)
% hObject    handle to ExperimentDelete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

if(length(handles.experimentlist)==0)  return;  end

set(handles.Status,'string','Thinking...');

idx=get(handles.ExperimentList,'Value');
handles.experimentlist(idx)=[];
handles.experimentvalue=min(handles.experimentvalue,length(handles.experimentlist));
handles.experimentvalue=max(handles.experimentvalue,1);
if(length(handles.experimentlist)==0)
  handles.experimentlist={};
  handles.experimentvalue=[];
  set(handles.ExperimentList,'enable','off');
  if(length(handles.experimentlist2)==0)
    set(handles.BehaviorList,'enable','off');
    set(handles.BehaviorLogic,'enable','off');
    set(handles.BehaviorList2,'enable','off');
    set(handles.FeatureList,'enable','off');
    set(handles.IndividualList,'enable','off');
  end
end
set(handles.ExperimentList,'String',handles.experimentlist);
set(handles.ExperimentList,'Value',handles.experimentvalue);

experiment_delete(hObject,handles,idx);


% --- Executes on button press in ExperimentMove2.
function ExperimentMove2_Callback(hObject, eventdata, handles)
% hObject    handle to ExperimentMove2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(length(handles.experimentlist2)==0)  return;  end

set(handles.Status,'string','Thinking...');

idx=get(handles.ExperimentList2,'Value');
idx2=length(handles.experimentlist);
handles.experimentlist={handles.experimentlist{:} handles.experimentlist2{idx}};
tmp=length(handles.experimentlist);
handles.experimentvalue=(tmp-length(idx)+1):tmp;
handles.experimentlist2(idx)=[];
handles.experimentvalue2=1;
if(length(handles.experimentlist2)==0)
  handles.experimentlist2={};
  handles.experimentvalue2=[];
  set(handles.ExperimentList2,'enable','off');
end
set(handles.ExperimentList,'String',handles.experimentlist);
set(handles.ExperimentList,'Value',handles.experimentvalue,'enable','on');
set(handles.ExperimentList2,'String',handles.experimentlist2);
set(handles.ExperimentList2,'Value',handles.experimentvalue2);
handles.behaviors=handles.behaviors([1:idx2 idx2+idx setdiff((idx2+1):length(handles.behaviors),idx2+idx)]);
handles.features=handles.features([1:idx2 idx2+idx setdiff((idx2+1):length(handles.behaviors),idx2+idx)]);
handles.individuals=handles.individuals([1:idx2 idx2+idx setdiff((idx2+1):length(handles.individuals),idx2+idx)]);
handles.sexdata=handles.sexdata([1:idx2 idx2+idx setdiff((idx2+1):length(handles.sexdata),idx2+idx)]);

handles=fillin_individuallist(handles);

handles.interesting_histograms=[];
handles.interesting_timeseries=[];

guidata(hObject,handles);

set(handles.Status,'string','Ready.');


% --- Executes on button press in ExperimentMove.
function ExperimentMove_Callback(hObject, eventdata, handles)
% hObject    handle to ExperimentMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(length(handles.experimentlist)==0)  return;  end

set(handles.Status,'string','Thinking...');

idx=get(handles.ExperimentList,'Value');
handles.experimentlist2={handles.experimentlist2{:} handles.experimentlist{idx}};
tmp=length(handles.experimentlist2);
handles.experimentvalue2=(tmp-length(idx)+1):tmp;
handles.experimentlist(idx)=[];
handles.experimentvalue=1;
if(length(handles.experimentlist)==0)
  handles.experimentlist={};
  handles.experimentvalue=[];
  set(handles.ExperimentList,'enable','off');
end
set(handles.ExperimentList2,'String',handles.experimentlist2);
set(handles.ExperimentList2,'Value',handles.experimentvalue2,'enable','on');
set(handles.ExperimentList,'String',handles.experimentlist);
set(handles.ExperimentList,'Value',handles.experimentvalue);
handles.behaviors=handles.behaviors([setdiff(1:length(handles.behaviors),idx) idx]);
handles.features=handles.features([setdiff(1:length(handles.features),idx) idx]);
handles.individuals=handles.individuals([setdiff(1:length(handles.individuals),idx) idx]);
handles.sexdata=handles.sexdata([setdiff(1:length(handles.sexdata),idx) idx]);

handles=fillin_individuallist(handles);

guidata(hObject,handles);

handles.interesting_histograms=[];
handles.interesting_timeseries=[];

set(handles.Status,'string','Ready.');


% --- Executes on selection change in IndividualList.
function IndividualList_Callback(hObject, eventdata, handles)
% hObject    handle to IndividualList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns IndividualList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from IndividualList


% --- Executes during object creation, after setting all properties.
function IndividualList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IndividualList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% ---
function ret_val=get_label(feature_name,feature_units)

ret_val=[strrep(char(feature_name),'_','-') ' ('];
if(~isempty(feature_units.num))
  if(length(feature_units.num)>1)
    ret_val=[ret_val '['];
  end
  tmp=char(feature_units.num);
  tmp=[tmp repmat('-',size(tmp,1),1)];
  tmp=reshape(tmp',1,numel(tmp));
  tmp=tmp(1:end-1);
  ret_val=[ret_val tmp];
  if(length(feature_units.num)>1)
    ret_val=[ret_val ']'];
  end
  if(~isempty(feature_units.den))
    ret_val=[ret_val ' / ' ];
  end
end
if(~isempty(feature_units.den))
  if(length(feature_units.den)>1)
    ret_val=[ret_val '['];
  end
  tmp=char(feature_units.den);
  tmp=[tmp repmat('-',size(tmp,1),1)];
  tmp=reshape(tmp',1,numel(tmp));
  tmp=tmp(1:end-1);
  ret_val=[ret_val tmp];
  if(length(feature_units.den)>1)
    ret_val=[ret_val ']'];
  end
  if(isempty(feature_units.num))
    ret_val=[ret_val ' ^ -1 ' ];
  end
end
ret_val=[ret_val ')'];


% --- 
function [during not_during]=calculate_histogram(behavior_data,behavior_logic,behavior_data2,...
    feature_data,sexdata,individual,perwhat)

if(iscell(feature_data.data{1}))
  vals=unique([feature_data.data{:}]);
  if(length(vals)~=2)  error('uhoh');  end
  for i=1:length(feature_data.data)
    feature_data.data{i}=strcmp(feature_data.data{i},vals{1});
  end
end

during={};  not_during={};
for i=1:length(behavior_data.allScores.t0s)  % individual
  if((~isnan(individual)) && (i~=individual))  continue;  end
  tmp1=false(1,length(feature_data.data{i}));
  for j=1:length(behavior_data.allScores.t0s{i})
    tmp1((behavior_data.allScores.t0s{i}(j):(behavior_data.allScores.t1s{i}(j)-1))...
        -behavior_data.allScores.tStart(i)+1)=true;
  end
  if(behavior_logic>1)
    tmp2=false(1,length(feature_data.data{i}));
    for j=1:length(behavior_data2.allScores.t0s{i})
      tmp2((behavior_data2.allScores.t0s{i}(j):(behavior_data2.allScores.t1s{i}(j)-1))...
          -behavior_data2.allScores.tStart(i)+1)=true;
    end
  end
  switch(behavior_logic)
    case(1)
      partition_idx=tmp1;
    case(2)
      partition_idx=tmp1 & tmp2;
    case(3)
      partition_idx=tmp1 & ~tmp2;
    case(4)
      partition_idx=tmp1 | tmp2;
  end
  if(perwhat==1)  % per frame
    during{i}=feature_data.data{i}(partition_idx & sexdata{i}(1:length(partition_idx)));
    not_during{i}=feature_data.data{i}((~partition_idx) & sexdata{i}(1:length(partition_idx)));
  else  % per bout
    partition_idx=[0 partition_idx 0];
    start=1+find(~partition_idx(1:(end-1)) &  partition_idx(2:end))-1;
    stop =  find( partition_idx(1:(end-1)) & ~partition_idx(2:end))-1;
    if(length(start)>0)
      for j=1:length(start)
        if(sum(sexdata{i}(start(j):stop(j))) < ((stop(j)-start(j)+1)/2))  continue;  end
        switch(perwhat)
          case 2
            during{i}(j)=mean(feature_data.data{i}(start(j):stop(j)));
          case 3
            during{i}(j)=median(feature_data.data{i}(start(j):stop(j)));
          case 4
            during{i}(j)=max(feature_data.data{i}(start(j):stop(j)));
          case 5
            during{i}(j)=min(feature_data.data{i}(start(j):stop(j)));
          case 6
            during{i}(j)=std(feature_data.data{i}(start(j):stop(j)));
        end
      end
      if(length(start)>1)
        for j=1:(length(start)-1)
          if(sum(sexdata{i}(stop(j):start(j+1))) < ((start(j+1)-stop(j)+1)/2))  continue;  end
          switch(perwhat)
            case 2
              not_during{i}(j)=mean(feature_data.data{i}(stop(j):start(j+1)));
            case 3
              not_during{i}(j)=median(feature_data.data{i}(stop(j):start(j+1)));
            case 4
              not_during{i}(j)=max(feature_data.data{i}(stop(j):start(j+1)));
            case 5
              not_during{i}(j)=min(feature_data.data{i}(stop(j):start(j+1)));
            case 6
              not_during{i}(j)=std(feature_data.data{i}(stop(j):start(j+1)));
          end
        end
      end
    end
  end
end

during=[during{:}];
not_during=[not_during{:}];


% ---
function [table_data feature_units]=plot_histogram(experiment_value,experiment_list,...
    behavior_value,behavior_list,behavior_logic,behavior_value2,behavior_list2,...
    feature_value,feature_list,individual,sexdata,perwhat,color)

during={};  not_during={};  feature_units={};
parfor e=1:length(experiment_value)
  behavior_data=load(fullfile(char(experiment_list(experiment_value(e))),...
        char(behavior_list(behavior_value))));
  if(behavior_logic>1)
    behavior_data2=load(fullfile(char(experiment_list(experiment_value(e))),...
        char(behavior_list2(behavior_value2))));
  else
    behavior_data2=[];
  end
  feature_data=load(fullfile(char(experiment_list(experiment_value(e))),'perframe',...
        char(feature_list(feature_value))));
  feature_units{e}=feature_data.units;

  tmp2=sexdata{e};
  for i=1:length(tmp2)
    switch(individual)
      case(2)
      case(3)
        tmp2{i}=~tmp2{i};
      otherwise
        tmp2{i}=ones(1,length(tmp2{i}));
    end
  end
  tmp=nan;  if(individual>3)  tmp=individual-3;  end

  [during{e} not_during{e}]=calculate_histogram(behavior_data,behavior_logic,behavior_data2,...
      feature_data,tmp2,tmp,perwhat);
end
during=[during{:}];
not_during=[not_during{:}];
feature_units=feature_units{1};

table_data={2,7};
table_data{1,1}='    during ';
table_data{1,2}=sprintf('%10.3g ',mean(during));
table_data{1,3}=sprintf('%10.3g ',std(during));
table_data{1,4}=sprintf('%10.3g ',std(during)./sqrt(length(during)));
table_data{1,5}=sprintf('%10.3g ',median(during));
table_data{1,6}=sprintf('%10.3g ',prctile(during,25));
table_data{1,7}=sprintf('%10.3g ',prctile(during,75));
%table_data{1,7}=sprintf('%10.3g-%10.3g ',[prctile(during,5) prctile(during,95)]);

table_data{2,1}='not during ';
table_data{2,2}=sprintf('%10.3g ',mean(not_during));
table_data{2,3}=sprintf('%10.3g ',std(not_during));
table_data{2,4}=sprintf('%10.3g ',std(not_during)./sqrt(length(not_during)));
table_data{2,5}=sprintf('%10.3g ',median(not_during));
table_data{2,6}=sprintf('%10.3g ',prctile(not_during,25));
table_data{2,7}=sprintf('%10.3g ',prctile(not_during,75));
%table_data{2,7}=sprintf('%10.3g-%10.3g ',[prctile(not_during,5) prctile(not_during,95)]);

tmp=linspace(min([during not_during]),max([during not_during]));
hist_during=hist(during,tmp);
hist_not_during=hist(not_during,tmp);
plot(tmp,hist_not_during./sum(hist_not_during),[color '-']);
plot(tmp,hist_during./sum(hist_during),[color '-'],'linewidth',3);


% --- Executes on button press in FeatureHistogram.
function FeatureHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to FeatureHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

set(handles.Status,'string','Thinking...');  drawnow;

experiment_value=get(handles.ExperimentList,'Value');
experiment_list=get(handles.ExperimentList,'String');
experiment_value2=get(handles.ExperimentList2,'Value');
experiment_list2=get(handles.ExperimentList2,'String');
behavior_value=get(handles.BehaviorList,'Value');
behavior_list=get(handles.BehaviorList,'String');
behavior_logic=get(handles.BehaviorLogic,'Value');
behavior_value2=get(handles.BehaviorList2,'Value');
behavior_list2=get(handles.BehaviorList2,'String');
feature_value=get(handles.FeatureList,'Value');
feature_list=get(handles.FeatureList,'String');
individual=get(handles.IndividualList,'Value');
perwhat=handles.histogram_perwhat;
sexdata=handles.sexdata;

axes(handles.Axes);
cla;  hold on;

if(individual>3)
  tmp=[0 cumsum(handles.individuals)];
  tmp2=find(tmp<(individual-3),1,'last');
  if(tmp2>length(experiment_list))
    experiment_value=[];
    experiment_value2=tmp2-length(experiment_list);
  else
    experiment_value=tmp2;
    experiment_value2=[];
  end
  individual=individual-tmp(tmp2);
end

if(length(experiment_value)>0)
  [table_data feature_units]=plot_histogram(experiment_value,experiment_list,...
      behavior_value,behavior_list,behavior_logic,behavior_value2,behavior_list2,...
      feature_value,feature_list,individual,sexdata(1:length(experiment_list)),perwhat,'r');
end
if(length(experiment_value2)>0)
  [table_data2 feature_units]=plot_histogram(experiment_value2,experiment_list2,...
      behavior_value,behavior_list,behavior_logic,behavior_value2,behavior_list2,...
      feature_value,feature_list,individual,sexdata((length(experiment_list)+1):end),perwhat,'b');
end

xlabel(get_label(feature_list(feature_value),feature_units));
ylabel('normalized');
axis tight

if((length(experiment_value)>0) && (length(experiment_value2)>0))
  tmp=[table_data(1,:); table_data2(1,:); table_data(2,:); table_data2(2,:)]; 
elseif(length(experiment_value)>0)
  tmp=table_data;
elseif(length(experiment_value2)>0)
  tmp=table_data2;
end

clear tmp2
{'' 'Mean' 'Std.Dev.' 'Std.Err.' 'Median' '25%' '75%'};
tmp2(1,:)=sprintf('%10s ',ans{:});
for i=1:size(tmp,1)
  tmp2(i+1,:)=[tmp{i,:}];
end
v=axis;
h=text(v(1),v(4),tmp2,'color',[0 0.5 0],'tag','stats','verticalalignment','top','fontname','fixed');
if(handles.stats)
  set(h,'visible','on');
else
  set(h,'visible','off');
end

guidata(hObject,handles);

set(handles.Status,'string','Ready.');


% ---
function table_data=calculate_interesting_histograms(experiment_value,experiment_list,...
    behavior_list,feature_list)

table_data=zeros(length(behavior_list),length(feature_list),6);
parfor b=1:length(behavior_list)
  k=1;
  parfor_tmp=zeros(length(feature_list),6);
  for f=1:length(feature_list)
    during={};  not_during={};
    for e=1:length(experiment_value)
      behavior_data=load(fullfile(char(experiment_list(experiment_value(e))),char(behavior_list(b))));
      feature_data=load(fullfile(char(experiment_list(experiment_value(e))),'perframe',char(feature_list(f))));
      sexdata={};
      for i=1:length(feature_data.data)
        sexdata{i}=ones(1,length(feature_data.data{i}));
      end
      [during{e} not_during{e}]=calculate_histogram(behavior_data,1,[],feature_data,sexdata,nan,1);
    end
    during=[during{:}];
    not_during=[not_during{:}];
    %parfor_tmp(k,:)=[b f (mean(during)-mean(not_during))/sqrt((std(during)^2+std(not_during)^2)/2)];
    parfor_tmp(k,:)=[b f mean(during) mean(not_during) std(during) std(not_during)];
    k=k+1;
  end
  table_data(b,:,:)=parfor_tmp;
  disp([num2str(b) ' of ' num2str(length(behavior_list))]);
end
table_data=reshape(table_data,prod(size(table_data))/6,6);


% --- Executes on button press in InterestingHistograms.
function InterestingHistograms_Callback(hObject, eventdata, handles)
% hObject    handle to InterestingHistograms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

set(handles.Status,'string','Thinking...');  drawnow;

experiment_value=get(handles.ExperimentList,'Value');
experiment_list=get(handles.ExperimentList,'String');
experiment_value2=get(handles.ExperimentList2,'Value');
experiment_list2=get(handles.ExperimentList2,'String');
behavior_list=get(handles.BehaviorList,'String');
feature_list=get(handles.FeatureList,'String');

if(isempty(handles.interesting_histograms))
  if(length(experiment_value)>0)
    table_data=calculate_interesting_histograms(experiment_value,experiment_list,...
        behavior_list,feature_list);
  end
  if(length(experiment_value2)>0)
    table_data2=calculate_interesting_histograms(experiment_value2,experiment_list2,...
        behavior_list,feature_list);
  end

  if((length(experiment_value)>0) && (length(experiment_value2)>0))
    tmp2=[table_data(:,1:2) (table_data2(:,3)-table_data(:,3))./sqrt(table_data2(:,5).^2+table_data(:,5).^2)];
  elseif(length(experiment_value)>0)
    tmp2=[table_data(:,1:2) (table_data(:,3)-table_data(:,4))./sqrt(table_data(:,5).^2+table_data(:,6).^2)];
  elseif(length(experiment_value2)>0)
    tmp2=[table_data2(:,1:2) (table_data2(:,3)-table_data2(:,4))./sqrt(table_data2(:,5).^2+table_data2(:,6).^2)];
  end

  tmp2=sortrows(tmp2,-3);

  handles.interesting_histograms=tmp2;
else
  tmp2=handles.interesting_histograms;
end

tmp=cell(size(tmp2));
tmp(:,1)=behavior_list(tmp2(:,1));
tmp(:,2)=feature_list(tmp2(:,2));
tmp(:,3)=num2cell(tmp2(:,3));
set(handles.Table,'Data',tmp);
set(handles.Table,'ColumnName',{'Behavior' 'Feature' 'd'''});
set(handles.Table,'ColumnWidth',{150 150 50});
set(handles.Table,'RowStriping','on','BackgroundColor',[1 1 1; 0.95 0.95 0.95]);

handles.table_data=tmp2;
handles.table='histogram';
guidata(hObject,handles);

set(handles.Status,'string','Ready.');


% --- 
function triggered_data=calculate_timeseries(behavior_data,behavior_logic,behavior_data2,feature_data,...
    sexdata,individual,timing,statistic,windowradius,subtractmean)

if(iscell(feature_data.data{1}))
  vals=unique([feature_data.data{:}]);
  if(length(vals)~=2)  error('uhoh');  end
  for i=1:length(feature_data.data)
    feature_data.data{i}=strcmp(feature_data.data{i},vals{1});
  end
end

k=1;
%triggered_data=zeros(length([behavior_data.allScores.t0s{:}]),1+2*windowradius);
triggered_data=[];
for i=1:length(behavior_data.allScores.t0s)  % individual
  if((~isnan(individual)) && (i~=individual))  continue;  end
  feature_data_padded=[nan(1,windowradius) feature_data.data{i} nan(1,windowradius)];
  sexdata_padded=[nan(1,windowradius) sexdata{i} nan(1,windowradius)];
  if(behavior_logic>1)
    idx2=[behavior_data2.allScores.t0s{i}'-behavior_data2.allScores.tStart(i) ...
       behavior_data2.allScores.t1s{i}'-behavior_data2.allScores.tStart(i)];
  end
  for j=1:length(behavior_data.allScores.t0s{i})  % bout
    switch(timing)
      case(1)
        idx=behavior_data.allScores.t0s{i}(j)-behavior_data.allScores.tStart(i);
      case(2)
        idx=behavior_data.allScores.t1s{i}(j)-behavior_data.allScores.tStart(i);
    end
    if((behavior_logic==2) && (diff(sum(idx2<idx))==0))
      continue;
    end
    if((behavior_logic==3) && (diff(sum(idx2<idx))==-1))
      continue;
    end
    if(sum(sexdata_padded(idx+(0:(2*windowradius))+(2-timing))) < windowradius)  continue;  end
    triggered_data(k,:)=feature_data_padded(idx+(0:(2*windowradius))+(2-timing));
    k=k+1;
  end
end
if(subtractmean)
  triggered_data=triggered_data-...
      repmat(nanmean(triggered_data(:,1:windowradius),2),1,size(triggered_data,2));
end


%---
function [table_data feature_units range h]=plot_timeseries(experiment_value,experiment_list,...
    behavior_value,behavior_list,behavior_logic,behavior_value2,behavior_list2,...
    feature_value,feature_list,individual,sexdata,timing,statistic,subtractmean,windowradius,color)

triggered_data=[];  feature_units={};
parfor e=1:length(experiment_value)
  behavior_data=load(fullfile(char(experiment_list(experiment_value(e))),...
      char(behavior_list(behavior_value))));
  if(behavior_logic>1)
    behavior_data2=load(fullfile(char(experiment_list(experiment_value(e))),...
        char(behavior_list2(behavior_value2))));
  else
    behavior_data2=[];
  end
  feature_data=load(fullfile(char(experiment_list(experiment_value(e))),'perframe',...
      char(feature_list(feature_value))));
  feature_units{e}=feature_data.units;

  tmp2=sexdata{e};
  for i=1:length(tmp2)
    switch(individual)
      case(2)
      case(3)
        tmp2{i}=~tmp2{i};
      otherwise
        tmp2{i}=ones(1,length(tmp2{i}));
    end
  end
  tmp=nan;  if(individual>3)  tmp=individual-3;  end

  tmp=calculate_timeseries(behavior_data,behavior_logic,behavior_data2,...
      feature_data,tmp2,tmp,timing,statistic,windowradius,subtractmean);
  triggered_data=[triggered_data; tmp];
end

feature_units=feature_units{1};

table_data=[sqrt(nanmean(triggered_data(:,1:windowradius).^2,2))...
            sqrt(nanmean(triggered_data(:,(windowradius+1):end).^2,2))];

k=size(triggered_data,1);
if(statistic<4)
  triggered_data(k+3,:)=nanmean(triggered_data(1:k,:),1);
  tmp=nanstd(triggered_data(1:k,:),1)./sqrt(k);
  triggered_data(k+2,:)=triggered_data(k+3,:)+tmp;
  triggered_data(k+4,:)=triggered_data(k+3,:)-tmp;
  tmp=nanstd(triggered_data(1:k,:),1);
  triggered_data(k+1,:)=triggered_data(k+3,:)+tmp;
  triggered_data(k+5,:)=triggered_data(k+3,:)-tmp;
else
  triggered_data(k+1,:)=prctile(triggered_data(1:k,:),95,1);
  triggered_data(k+2,:)=prctile(triggered_data(1:k,:),75,1);
  triggered_data(k+3,:)=nanmedian(triggered_data(1:k,:),1);
  triggered_data(k+4,:)=prctile(triggered_data(1:k,:),25,1);
  triggered_data(k+5,:)=prctile(triggered_data(1:k,:), 5,1);
end

plot(-windowradius:windowradius,triggered_data(1:end-5,:)','k-');
h(1)=plot(-windowradius:windowradius,triggered_data(end-2,:)',[color '-'],'linewidth',3);
range=[min(triggered_data(end-2,:)) max(triggered_data(end-2,:))];
switch(statistic)
  case {2,5}
    h(2)=plot(-windowradius:windowradius,triggered_data(end-4,:)',[color '-'],'linewidth',1);
    h(3)=plot(-windowradius:windowradius,triggered_data(end-0,:)',[color '-'],'linewidth',1);
    range=[range; min(triggered_data(end-4,:)) max(triggered_data(end-4,:))];
    range=[range; min(triggered_data(end-0,:)) max(triggered_data(end-0,:))];
  case {3,6}
    h(2)=plot(-windowradius:windowradius,triggered_data(end-3,:)',[color '-'],'linewidth',1);
    h(3)=plot(-windowradius:windowradius,triggered_data(end-1,:)',[color '-'],'linewidth',1);
    range=[range; min(triggered_data(end-3,:)) max(triggered_data(end-3,:))];
    range=[range; min(triggered_data(end-1,:)) max(triggered_data(end-1,:))];
end


% --- Executes on button press in FeatureTimeSeries.
function FeatureTimeSeries_Callback(hObject, eventdata, handles)
% hObject    handle to FeatureTimeSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

set(handles.Status,'string','Thinking...');  drawnow;

experiment_value=get(handles.ExperimentList,'Value');
experiment_list=get(handles.ExperimentList,'String');
experiment_value2=get(handles.ExperimentList2,'Value');
experiment_list2=get(handles.ExperimentList2,'String');
behavior_value=get(handles.BehaviorList,'Value');
behavior_list=get(handles.BehaviorList,'String');
behavior_logic=get(handles.BehaviorLogic,'Value');
behavior_value2=get(handles.BehaviorList2,'Value');
behavior_list2=get(handles.BehaviorList2,'String');
feature_value=get(handles.FeatureList,'Value');
feature_list=get(handles.FeatureList,'String');
individual=get(handles.IndividualList,'Value');
sexdata=handles.sexdata;
timing=handles.timeseries_timing;
statistic=handles.timeseries_statistic;
windowradius=handles.timeseries_windowradius;
subtractmean=handles.timeseries_subtractmean;

axes(handles.Axes);
cla;  hold on;

if(individual>3)
  tmp=[0 cumsum(handles.individuals)];
  tmp2=find(tmp<(individual-3),1,'last');
  if(tmp2>length(experiment_list))
    experiment_value=[];
    experiment_value2=tmp2-length(experiment_list);
  else
    experiment_value=tmp2;
    experiment_value2=[];
  end
  individual=individual-tmp(tmp2);
end

range=[];
if(length(experiment_value)>0)
  [table_data feature_units tmp h]=plot_timeseries(experiment_value,experiment_list,...
      behavior_value,behavior_list,behavior_logic,behavior_value2,behavior_list2,...
      feature_value,feature_list,individual,sexdata(1:length(experiment_list)),...
      timing,statistic,subtractmean,windowradius,'r');
  range=[range; tmp];
end
if(length(experiment_value2)>0)
  [table_data2 feature_units tmp h2]=plot_timeseries(experiment_value2,experiment_list2,...
      behavior_value,behavior_list,behavior_logic,behavior_value2,behavior_list2,...
      feature_value,feature_list,individual,sexdata((length(experiment_list)+1):end),...
      timing,statistic,subtractmean,windowradius,'b');
  range=[range; tmp];
  if(length(experiment_value)>0)
    uistack(h,'top');
    uistack(h2,'top');
  end
end

xlabel('time (frames)');
ylabel(get_label(feature_list(feature_value),feature_units));
axis tight
if(handles.timeseries_tight==1)
  v=axis;  axis([v(1) v(2) min(range(:,1)) max(range(:,2))]);
end

if((length(experiment_value)>0) && (length(experiment_value2)>0))
  tmp=[nanmean(table_data(:,1))  nanstd(table_data(:,1))  nanmean(table_data(:,2))  nanstd(table_data(:,2));...
       nanmean(table_data2(:,1)) nanstd(table_data2(:,1)) nanmean(table_data2(:,2)) nanstd(table_data2(:,2))];
elseif(length(experiment_value)>0)
  tmp=[nanmean(table_data(:,1))  nanstd(table_data(:,1))  nanmean(table_data(:,2))  nanstd(table_data(:,2))];
elseif(length(experiment_value2)>0)
  tmp=[nanmean(table_data2(:,1)) nanstd(table_data2(:,1)) nanmean(table_data2(:,2)) nanstd(table_data2(:,2))];
end

{'mean' 'std. dev.' 'mean' 'std. dev.'};
tmp2(1,:)=['RMS before,after:' sprintf('%10s ',ans{:})];
for i=1:size(tmp,1)
  tmp2(i+1,:)=['                 ' sprintf('%10.3g ',tmp(i,:))];
end
v=axis;
h=text(v(1),v(4),tmp2,'color',[0 0.5 0],'tag','stats','verticalalignment','top','fontname','fixed');
if(handles.stats)
  set(h,'visible','on');
else
  set(h,'visible','off');
end
set(handles.Status,'string','Ready.');


% ---
function table_data=calculate_interesting_timeseries(experiment_value,experiment_list,...
    behavior_list,feature_list,statistic,windowradius)

table_data=cell(length(behavior_list),length(feature_list),2);
parfor b=1:length(behavior_list)
  parfor_tmp=cell(length(feature_list),2);
  for f=1:length(feature_list)
    for t=1:2  % timing
      parfor_tmp{f,t}=[];
      for e=1:length(experiment_value)
        behavior_data=load(fullfile(char(experiment_list(experiment_value(e))),char(behavior_list(b))));
        feature_data=load(fullfile(char(experiment_list(experiment_value(e))),'perframe',char(feature_list(f))));
%        sex_data=load(fullfile(char(experiment_list(experiment_value(e))),'perframe',...
%            char(feature_list(find(strcmp(feature_list,'sex.mat'))))));
        sexdata={};
        for i=1:length(feature_data.data)
          sexdata{i}=ones(1,length(feature_data.data{i}));
        end

        tmp=calculate_timeseries(behavior_data,1,[],feature_data,sexdata,nan,t,statistic,windowradius,1);
        parfor_tmp{f,t}=[parfor_tmp{f,t}; tmp];
      end
      parfor_tmp{f,t}=[...
          sqrt(nanmean(parfor_tmp{f,t}(:,1:windowradius).^2,2))...
          sqrt(nanmean(parfor_tmp{f,t}(:,(windowradius+1):end).^2,2))];
    end
  end
  table_data(b,:,:)=parfor_tmp;
  disp([num2str(b) ' of ' num2str(length(behavior_list))]);
end
%table_data=reshape(table_data,prod(size(table_data))/5,5);


% --- Executes on button press in InterestingTimeSeries.
function InterestingTimeSeries_Callback(hObject, eventdata, handles)
% hObject    handle to InterestingTimeSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user experiment (see GUIDATA)

set(handles.Status,'string','Thinking...');  drawnow;

experiment_value=get(handles.ExperimentList,'Value');
experiment_list=get(handles.ExperimentList,'String');
experiment_value2=get(handles.ExperimentList2,'Value');
experiment_list2=get(handles.ExperimentList2,'String');
behavior_list=get(handles.BehaviorList,'String');
feature_list=get(handles.FeatureList,'String');
statistic=handles.timeseries_statistic;
windowradius=handles.timeseries_windowradius;

if(isempty(handles.interesting_timeseries))
  if(length(experiment_value)>0)
    table_data=calculate_interesting_timeseries(experiment_value,experiment_list,...
        behavior_list,feature_list,statistic,windowradius);
  end
  if(length(experiment_value2)>0)
    table_data2=calculate_interesting_timeseries(experiment_value2,experiment_list2,...
        behavior_list,feature_list,statistic,windowradius);
  end

  if((length(experiment_value)>0) && (length(experiment_value2)>0))
    tmp=(cellfun(@(x) nanmean(x(:,2)),table_data2) - cellfun(@(x) nanmean(x(:,2)),table_data)) ./ ...
        sqrt(cellfun(@(x) nanstd(x(:,2)),table_data2).^2 + cellfun(@(x) nanstd(x(:,2)),table_data).^2);
  elseif(length(experiment_value)>0)
    tmp=cellfun(@(x) (nanmean(x(:,2))-nanmean(x(:,1)))/sqrt(nanstd(x(:,2)).^2+nanstd(x(:,1)).^2),table_data);
  elseif(length(experiment_value2)>0)
    tmp=cellfun(@(x) (nanmean(x(:,2))-nanmean(x(:,1)))/sqrt(nanstd(x(:,2)).^2+nanstd(x(:,1)).^2),table_data2);
  end
  [tmp2(:,1) tmp2(:,2) tmp2(:,3)]=ind2sub(size(tmp),1:prod(size(tmp)));
  tmp2(:,4)=tmp(1:prod(size(tmp)));
  tmp2=sortrows(tmp2,-4);

  handles.interesting_timeseries=tmp2;
else
  tmp2=handles.interesting_timeseries;
end

tmp=cell(size(tmp2));
tmp(:,1)=behavior_list(tmp2(:,1));
tmp(:,2)=feature_list(tmp2(:,2));
tmp(:,3)=repmat({'Onset'},size(tmp2,1),1);
  find(tmp2(:,3)==2);
  tmp(ans,3)=repmat({'Offset'},size(ans),1);
tmp(:,4)=num2cell(tmp2(:,4));

set(handles.Table,'Data',tmp);
set(handles.Table,'ColumnName',{'Behavior' 'Feature' 'Timing' 'dRMS'});
set(handles.Table,'ColumnWidth',{150 150 50 50 50});
set(handles.Table,'RowStriping','on','BackgroundColor',[1 1 1; 0.95 0.95 0.95]);

handles.table_data=tmp2;
handles.table='timeseries';
guidata(hObject,handles);

set(handles.Status,'string','Ready.');


% --- 
function [male_count female_count male_total female_total individual_count]=...
    calculate_behaviorstats2(behavior_data,behavior_logic,behavior_data2,sexdata)

male_count=0;  female_count=0;  individual_count=[];
male_total=0;  female_total=0;
%partition_idx=cell(1,length(behavior_data.allScores.t0s));
for i=1:length(behavior_data.allScores.t0s)  % individual
  tmp1=false(1,length(sexdata{i}));
  for j=1:length(behavior_data.allScores.t0s{i})  % bout
    tmp1((behavior_data.allScores.t0s{i}(j):(behavior_data.allScores.t1s{i}(j)-1))...
        -behavior_data.allScores.tStart(i)+1)=true;
  end
  if(behavior_logic>1)
    tmp2=false(1,length(sexdata{i}));
    for j=1:length(behavior_data2.allScores.t0s{i})  % bout
      tmp2((behavior_data2.allScores.t0s{i}(j):(behavior_data2.allScores.t1s{i}(j)-1))...
          -behavior_data2.allScores.tStart(i)+1)=true;
    end
  end
  switch(behavior_logic)
    case(1)
      partition_idx=tmp1;
    case(2)
      partition_idx=tmp1 & tmp2;
    case(3)
      partition_idx=tmp1 & ~tmp2;
    case(4)
      partition_idx=tmp1 | tmp2;
  end
  male_count=male_count+sum(partition_idx & sexdata{i}(1:length(partition_idx)));
  female_count=female_count+sum(partition_idx & (~sexdata{i}(1:length(partition_idx))));
  male_total=male_total+sum(sexdata{i}(1:length(partition_idx)));
  female_total=female_total+sum(~sexdata{i}(1:length(partition_idx)));
  individual_count(i)=100*sum(partition_idx)./length(partition_idx);
end


% ---
function table_data=calculate_behaviorstats(experiment_value,experiment_list,...
    behavior_list,behavior_logic,behavior_value2,behavior_list2,feature_list,sexdata)

collated_data=cell(1,length(experiment_value));
parfor e=1:length(experiment_value)
%  sex_data=load(fullfile(char(experiment_list(experiment_value(e))),'perframe',...
%      char(feature_list(find(strcmp(feature_list,'sex.mat'))))));
%  for i=1:length(sex_data.data)
%    sex_data.data{i}=strcmp(sex_data.data{i},'M');
%  end
  behavior_data=load(fullfile(char(experiment_list(experiment_value(e))),char(behavior_list(1))));
  collated_data{e}=nan(length(behavior_list),4+length(behavior_data.allScores.t0s));
  if(behavior_logic>1)
    behavior_data2=load(fullfile(char(experiment_list(experiment_value(e))),...
        char(behavior_list2(behavior_value2))));
  else
    behavior_data2=[];
  end
  for b=1:length(behavior_list)
    behavior_data=load(fullfile(char(experiment_list(experiment_value(e))),char(behavior_list(b))));

    [male_count female_count male_total female_total individual_count]=...
        calculate_behaviorstats2(behavior_data,behavior_logic,behavior_data2,sexdata{e});
    if((4+length(individual_count))>size(collated_data{e},2))
      collated_data{e}(:,(end+1):(4+length(individual_count)))=...
          nan(size(collated_data{e},1):((4+length(individual_count))-size(collated_data{e},2)));
    end
    collated_data{e}(b,:)=[male_count female_count male_total female_total individual_count];
  end
end

%table_data=nan(length(behavior_list),4+sum(cellfun(@(x) size(x,2),collated_data))-4*length(experiment_value));
table_data={};
%raw_table_data={};
for b=1:length(behavior_list)
  table_data{b,1}=behavior_list{b};
  tmp1=cellfun(@(x) x(b,1:2),collated_data,'uniformoutput',false);
  tmp2=cellfun(@(x) x(b,3:4),collated_data,'uniformoutput',false);
  table_data{b,2}=sum(sum([tmp1{:}])) / sum(sum([tmp2{:}])) .* 100;
  sum(cat(1,tmp1{:}),1) ./ sum(cat(1,tmp2{:}),1) .* 100;
  table_data{b,3}=ans(1);
  table_data{b,4}=ans(2);
  cellfun(@(x) x(b,5:end),collated_data,'uniformoutput',false);
  cat(2,ans{:});
  for i=1:length(ans)
    table_data{b,4+i}=ans(i);
  end
end

%ret_val=cell(size(table_data));
%ret_val(:,1)=behavior_list(table_data(:,1));
%ret_val(:,2:end)=num2cell(table_data(:,2:end));


% --- Executes on button press in BehaviorStats.
function BehaviorStats_Callback(hObject, eventdata, handles)
% hObject    handle to BehaviorStats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Status,'string','Thinking...');  drawnow;

experiment_value=get(handles.ExperimentList,'Value');
experiment_list=get(handles.ExperimentList,'String');
experiment_value2=get(handles.ExperimentList2,'Value');
experiment_list2=get(handles.ExperimentList2,'String');
behavior_list=get(handles.BehaviorList,'String');
behavior_logic=get(handles.BehaviorLogic,'Value');
behavior_value2=get(handles.BehaviorList2,'Value');
behavior_list2=get(handles.BehaviorList2,'String');
feature_list=get(handles.FeatureList,'String');
sexdata=handles.sexdata;

if(length(experiment_value)>0)
  table_data=calculate_behaviorstats(experiment_value,experiment_list,...
      behavior_list,behavior_logic,behavior_value2,behavior_list2,feature_list,...
      sexdata(1:length(experiment_list)));
end
if(length(experiment_value2)>0)
  table_data2=calculate_behaviorstats(experiment_value2,experiment_list2,...
      behavior_list,behavior_logic,behavior_value2,behavior_list2,feature_list,...
      sexdata((length(experiment_list)+1):end));
end

if((length(experiment_value)>0) && (length(experiment_value2)>0))
  set(handles.Table,'RowStriping','on','BackgroundColor',[1 0.8 0.8; 0.8 0.8 1]);
  tmp(1:2:2*size(table_data2,1),1:size(table_data, 2))=table_data;
  tmp(2:2:2*size(table_data2,1),1:size(table_data2,2))=table_data2;
  ii=max(size(table_data,2),size(table_data2,2));
elseif(length(experiment_value)>0)
  set(handles.Table,'RowStriping','off','BackgroundColor',[1 0.8 0.8]);
  tmp=table_data;
  ii=size(table_data,2);
else
  set(handles.Table,'RowStriping','off','BackgroundColor',[0.8 0.8 1]);
  tmp=table_data2;
  ii=size(table_data2,2);
end

set(handles.Table,'Data',tmp);
tmp={'Behavior' 'Total %' 'Male %' 'Female %'};
for i=1:(ii-4)
  tmp{i+4}=['Indi #' num2str(i) ' %'];
end
set(handles.Table,'ColumnName',tmp);
set(handles.Table,'ColumnWidth',{150 75 75});

handles.table='behavior_stats';
guidata(hObject,handles);

set(handles.Status,'string','Ready.');


% --- 
function [bout_lengths sex inter_bout_lengths inter_sex]=...
    calculate_boutstats2(behavior_data,behavior_logic,behavior_data2,sexdata)

bout_lengths=cell(1,length(behavior_data.allScores.t0s));
inter_bout_lengths=cell(1,length(behavior_data.allScores.t0s));
sex=cell(1,length(behavior_data.allScores.t0s));
inter_sex=cell(1,length(behavior_data.allScores.t0s));
for i=1:length(behavior_data.allScores.t0s)  % individual
  tmp1=false(1,length(sexdata{i}));
  for j=1:length(behavior_data.allScores.t0s{i})  % bout
    tmp1((behavior_data.allScores.t0s{i}(j):(behavior_data.allScores.t1s{i}(j)-1))...
        -behavior_data.allScores.tStart(i)+1)=true;
  end
  if(behavior_logic>1)
    tmp2=false(1,length(sexdata{i}));
    for j=1:length(behavior_data2.allScores.t0s{i})  % bout
      tmp2((behavior_data2.allScores.t0s{i}(j):(behavior_data2.allScores.t1s{i}(j)-1))...
          -behavior_data2.allScores.tStart(i)+1)=true;
    end
  end
  switch(behavior_logic)
    case(1)
      partition_idx=tmp1;
    case(2)
      partition_idx=tmp1 & tmp2;
    case(3)
      partition_idx=tmp1 & ~tmp2;
    case(4)
      partition_idx=tmp1 | tmp2;
  end
  partition_idx=[0 partition_idx 0];
  start=1+find(~partition_idx(1:(end-1)) &  partition_idx(2:end))-1;
  stop =  find( partition_idx(1:(end-1)) & ~partition_idx(2:end))-1;
  if(length(start)>0)
    bout_lengths{i}=stop-start+1;
    sex{i}=zeros(1,length(bout_lengths{i}));
    for j=1:length(bout_lengths{i})
      sex{i}(j)=sum(sexdata{i}(start(j):stop(j))) > (bout_lengths{i}(j)/2);
    end
    if(length(start)>1)
      inter_bout_lengths{i}=start(2:end)-stop(1:(end-1));
      inter_sex{i}=zeros(1,length(inter_bout_lengths{i}));
      for j=1:length(inter_bout_lengths{i})
        inter_sex{i}(j)=sum(sexdata{i}(stop(j):start(j+1))) > (inter_bout_lengths{i}(j)/2);
      end
    end
  end
end


% ---
function ret_val=print_boutstats(data)

handles=guidata(gcf);

switch(handles.boutstats)
  case(1)
    ret_val=num2str(mean(data),3);
  case(2)
    ret_val=[num2str(mean(data),3) ' (' num2str(std(data),3) ')'];
  case(3)
    ret_val=[num2str(mean(data),3) ' (' num2str(std(data)./sqrt(length(data)),3) ')'];
  case(4)
    ret_val=num2str(median(data),3);
  case(5)
    ret_val=[num2str(median(data),3) ' (' num2str(prctile(data,5),3) '-' num2str(prctile(data,95),3) ')'];
  case(6)
    ret_val=[num2str(median(data),3) ' (' num2str(prctile(data,25),3) '-' num2str(prctile(data,75),3) ')'];
end


% ---
function [table_data raw_table_data]=calculate_boutstats(experiment_value,experiment_list,...
    behavior_list,behavior_logic,behavior_value2,behavior_list2,feature_list,sexdata)

collated_data=cell(length(experiment_value),length(behavior_list));
parfor e=1:length(experiment_value)
%  sex_data=load(fullfile(char(experiment_list(experiment_value(e))),'perframe',...
%      char(feature_list(find(strcmp(feature_list,'sex.mat'))))));
%  for i=1:length(sex_data.data)
%    sex_data.data{i}=strcmp(sex_data.data{i},'M');
%  end
  behavior_data=load(fullfile(char(experiment_list(experiment_value(e))),char(behavior_list(1))));
  if(behavior_logic>1)
    behavior_data2=load(fullfile(char(experiment_list(experiment_value(e))),...
        char(behavior_list2(behavior_value2))));
  else
    behavior_data2=[];
  end
  parfor_tmp=cell(1,length(behavior_list));
  for b=1:length(behavior_list)
    behavior_data=load(fullfile(char(experiment_list(experiment_value(e))),char(behavior_list(b))));

    [bout_lengths sex inter_bout_lengths inter_sex]=...
        calculate_boutstats2(behavior_data,behavior_logic,behavior_data2,sexdata{e});
    parfor_tmp{b}={bout_lengths sex inter_bout_lengths inter_sex};
  end
  collated_data(e,:)=parfor_tmp;
end

table_data={};
raw_table_data={};
for b=1:length(behavior_list)
  bout_lengths=[];  sex=[];  n=[];
  inter_bout_lengths=[];  inter_sex=[];  inter_n=[];
  for e=1:length(experiment_value)
    bout_lengths=[bout_lengths collated_data{e,b}{1}{:}];
    sex=[sex collated_data{e,b}{2}{:}];
    n=[n cellfun(@numel,collated_data{e,b}{1})];
    inter_bout_lengths=[inter_bout_lengths collated_data{e,b}{3}{:}];
    inter_sex=[inter_sex collated_data{e,b}{4}{:}];
    inter_n=[inter_n cellfun(@numel,collated_data{e,b}{3})];
  end
  n=[0 cumsum(n)];
  inter_n=[0 cumsum(inter_n)];
  table_data{b,1}=behavior_list{b};
  raw_table_data{b,2}=bout_lengths;
      table_data{b,2}=print_boutstats(raw_table_data{b,2});
  raw_table_data{b,3}=inter_bout_lengths;
      table_data{b,3}=print_boutstats(raw_table_data{b,3});
  raw_table_data{b,4}=bout_lengths(sex==1);
      table_data{b,4}=print_boutstats(raw_table_data{b,4});
  raw_table_data{b,5}=bout_lengths(sex==0);
      table_data{b,5}=print_boutstats(raw_table_data{b,5});
  raw_table_data{b,6}=inter_bout_lengths(inter_sex==1);
      table_data{b,6}=print_boutstats(raw_table_data{b,6});
  raw_table_data{b,7}=inter_bout_lengths(inter_sex==0);
      table_data{b,7}=print_boutstats(raw_table_data{b,7});
  for i=1:(length(n)-1)
    raw_table_data{b,6+2*i}=bout_lengths((n(i)+1):n(i+1));
        table_data{b,6+2*i}=print_boutstats(raw_table_data{b,7+i});
    raw_table_data{b,7+2*i}=inter_bout_lengths((inter_n(i)+1):inter_n(i+1));
        table_data{b,7+2*i}=print_boutstats(raw_table_data{b,8+i});
  end
end


% --- Executes on button press in BoutStats.
function BoutStats_Callback(hObject, eventdata, handles)
% hObject    handle to BoutStats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Status,'string','Thinking...');  drawnow;

experiment_value=get(handles.ExperimentList,'Value');
experiment_list=get(handles.ExperimentList,'String');
experiment_value2=get(handles.ExperimentList2,'Value');
experiment_list2=get(handles.ExperimentList2,'String');
behavior_list=get(handles.BehaviorList,'String');
behavior_logic=get(handles.BehaviorLogic,'Value');
behavior_value2=get(handles.BehaviorList2,'Value');
behavior_list2=get(handles.BehaviorList2,'String');
feature_list=get(handles.FeatureList,'String');
sexdata=handles.sexdata;

if(length(experiment_value)>0)
  [table_data raw_table_data]=calculate_boutstats(experiment_value,experiment_list,...
      behavior_list,behavior_logic,behavior_value2,behavior_list2,feature_list,...
      sexdata(1:length(experiment_list)));
end
if(length(experiment_value2)>0)
  [table_data2 raw_table_data2]=calculate_boutstats(experiment_value2,experiment_list2,...
      behavior_list,behavior_logic,behavior_value2,behavior_list2,feature_list,...
      sexdata((length(experiment_list)+1):end));
end

if((length(experiment_value)>0) && (length(experiment_value2)>0))
  set(handles.Table,'RowStriping','on','BackgroundColor',[1 0.8 0.8; 0.8 0.8 1]);
  tmp(1:2:2*size(table_data2,1),1:size(table_data, 2))=table_data;
  tmp(2:2:2*size(table_data2,1),1:size(table_data2,2))=table_data2;
  raw_tmp(1:2:2*size(raw_table_data2,1),1:size(raw_table_data, 2))=raw_table_data;
  raw_tmp(2:2:2*size(raw_table_data2,1),1:size(raw_table_data2,2))=raw_table_data2;
  ii=max(size(table_data,2),size(table_data2,2));
elseif(length(experiment_value)>0)
  set(handles.Table,'RowStriping','off','BackgroundColor',[1 0.8 0.8]);
  tmp=table_data;
  raw_tmp=raw_table_data;
  ii=size(table_data,2);
else
  set(handles.Table,'RowStriping','off','BackgroundColor',[0.8 0.8 1]);
  tmp=table_data2;
  raw_tmp=raw_table_data2;
  ii=size(table_data2,2);
end

set(handles.Table,'Data',tmp);
handles.raw_table_data=raw_tmp;
tmp={'Behavior' 'Bout Length' 'Inter BL' 'Male BL' 'Male IBL' 'Female BL' 'Female IBL'};
for i=1:(ii-7)/2
  tmp{2*i+6}=['Indi #' num2str(i) ' BL'];
  tmp{2*i+7}=['Indi #' num2str(i) ' IBL'];
end
set(handles.Table,'ColumnName',tmp);
set(handles.Table,'ColumnWidth',{150 75 75});

handles.table='bout_stats';
guidata(hObject,handles);

set(handles.Status,'string','Ready.');



% --- 
function Interesting_CellSelectionCallback(hObject,eventdata)

if(size(eventdata.Indices,1)==0)  return;  end

handles=guidata(hObject);

if(strcmp(handles.table,'bout_stats'))
  if(eventdata.Indices(end,2)==1)  return;  end

  experiment_value=get(handles.ExperimentList,'Value');
  experiment_value2=get(handles.ExperimentList2,'Value');
  if((length(experiment_value)>0) && (length(experiment_value2)>0))
    handles.behaviorvalue=ceil(eventdata.Indices(end,1)/2);
    if(mod(eventdata.Indices(end,1),2))
      color='r';
    else
      color='b';
    end
  elseif(length(experiment_value)>0)
    handles.behaviorvalue=eventdata.Indices(end,1);
    color='r';
  else
    handles.behaviorvalue=eventdata.Indices(end,1);
    color='b';
  end
  set(handles.BehaviorList,'Value',handles.behaviorvalue);
  handles.individualvalue=floor(eventdata.Indices(end,2)/2);
  if(((color=='r') && (handles.individualvalue>(3+sum(handles.individuals(1:length(handles.experimentlist)))))) || ...
     ((color=='b') && (handles.individualvalue>(3+sum(handles.individuals((end-length(handles.experimentlist2)+1):end))))))
    return;
  end
  if(color=='b')
    handles.individualvalue=handles.individualvalue+sum(handles.individuals(1:length(handles.experimentlist)));
  end
  set(handles.IndividualList,'Value',handles.individualvalue);

  axes(handles.Axes);
  cla;  hold on;
  data=handles.raw_table_data{eventdata.Indices(end,1),eventdata.Indices(end,2)};
  [n,x]=hist(data,100);
  plot(x,n./sum(n),[color '-']);
  xlabel('length (frames)');
  %ylabel(strrep(char(behavior_list(b)),'_','-'));
  axis tight;

  tmp={};
  tmp{1}=sprintf('%10.3g ',mean(data));
  tmp{2}=sprintf('%10.3g ',std(data));
  tmp{3}=sprintf('%10.3g ',std(data)./sqrt(length(data)));
  tmp{4}=sprintf('%10.3g ',median(data));
  tmp{5}=sprintf('%10.3g ',prctile(data,25));
  tmp{6}=sprintf('%10.3g ',prctile(data,75));

  {'Mean' 'Std.Dev.' 'Std.Err.' 'Median' '25%' '75%'};
  tmp2(1,:)=sprintf('%10s ',ans{:});
  for i=1:size(tmp,1)
    tmp2(i+1,:)=[tmp{i,:}];
  end
  v=axis;
  h=text(v(1),v(4),tmp2,'color',[0 0.5 0],'tag','stats','verticalalignment','top','fontname','fixed');
  if(handles.stats)
    set(h,'visible','on');
  else
    set(h,'visible','off');
  end
  
elseif(strcmp(handles.table,'behavior_stats'))
  if(eventdata.Indices(end,2)==1)  return;  end
  set(handles.Status,'string','Thinking...');  drawnow;

  experiment_value=get(handles.ExperimentList,'Value');
  experiment_list=get(handles.ExperimentList,'String');
  experiment_value2=get(handles.ExperimentList2,'Value');
  experiment_list2=get(handles.ExperimentList2,'String');
  behavior_list=get(handles.BehaviorList,'String');
  feature_list=get(handles.FeatureList,'String');

  if((length(experiment_value)>0) && (length(experiment_value2)>0))
    b=ceil(eventdata.Indices(end,1)/2);
    if(mod(eventdata.Indices(end,1),2))
      experiment_value0=experiment_value;
      experiment_list0=experiment_list;
      sexdata=handles.sexdata(1:length(experiment_list));
      color='r';
    else
      experiment_value0=experiment_value2;
      experiment_list0=experiment_list2;
      sexdata=handles.sexdata((length(experiment_list)+1):end);
      color='b';
    end
  elseif(length(experiment_value)>0)
    b=eventdata.Indices(end,1);
    experiment_value0=experiment_value;
    experiment_list0=experiment_list;
      sexdata=handles.sexdata(1:length(experiment_list));
    color='r';
  else
    b=eventdata.Indices(end,1);
    experiment_value0=experiment_value2;
    experiment_list0=experiment_list2;
    sexdata=handles.sexdata((length(experiment_list)+1):end);
    color='b';
  end

  if(eventdata.Indices(end,2)>4)
    e=1;  n=0;
    while((e<=length(experiment_value0)) && (n<eventdata.Indices(end,2)-4))
      behavior_data=load(fullfile(char(experiment_list0(experiment_value0(e))),...
          char(behavior_list(b))));
      e=e+1;
      n=n+length(behavior_data.allScores.t0s);
    end
    if(n<eventdata.Indices(end,2)-4)
      set(handles.Status,'string','Ready.');
      return;
    end
    ee=e-1;
    ii=eventdata.Indices(end,2)-4-(n-length(behavior_data.allScores.t0s));
  else
    ee=1:length(experiment_value0);
    ii=nan;
  end

  handles.behaviorvalue=b;
  set(handles.BehaviorList,'Value',handles.behaviorvalue);
  handles.individualvalue=eventdata.Indices(end,2)-1;
  if(color=='b')
    handles.individualvalue=handles.individualvalue+sum(handles.individuals(1:length(handles.experimentlist)));
  end
  set(handles.IndividualList,'Value',handles.individualvalue);

  cellfun(@(x) size(x{1},2),sexdata,'uniformoutput',false);
  behavior_cumulative=zeros(length(experiment_value0),max([ans{:}]));
  k=1;
  parfor e=ee
    behavior_data=load(fullfile(char(experiment_list0(experiment_value0(e))),...
        char(behavior_list(b))));
    parfor_tmp=zeros(1,length(behavior_cumulative(e,:)));
    for i=1:length(behavior_data.allScores.t0s)   % individual
      if((eventdata.Indices(end,2)>4)&&(i~=ii))  continue;  end
      partition_idx=false(1,length(sexdata{e}{i}));
      for j=1:length(behavior_data.allScores.t0s{i})  % bout
        partition_idx((behavior_data.allScores.t0s{i}(j):(behavior_data.allScores.t1s{i}(j)-1))...
            -behavior_data.allScores.tStart(i)+1)=true;
      end
      switch(eventdata.Indices(end,2))
        case(3)
          partition_idx = partition_idx & sexdata{e}{i}(1:length(partition_idx));
        case(4)
          partition_idx = partition_idx & (~sexdata{e}{i}(1:length(partition_idx)));
      end
      idx=find(partition_idx);
      parfor_tmp(idx)=parfor_tmp(idx)+1;
      k=k+1;
    end
    behavior_cumulative(e,:)=parfor_tmp;
  end
  behavior_cumulative=sum(behavior_cumulative,1)./k.*100;
  behavior_cumulative=conv(behavior_cumulative,ones(1,100)./100,'same');
  axes(handles.Axes);
  cla;  hold on;
  plot(behavior_cumulative,[color '-']);
  xlabel('time (frames)');
  ylabel([strrep(char(behavior_list(b)),'_','-') ' (%)']);
  axis tight;

  guidata(hObject,handles);
  set(handles.Status,'string','Ready.');

elseif(strcmp(handles.table,'timeseries') || strcmp(handles.table,'histogram'))
  handles.behaviorvalue=handles.table_data(eventdata.Indices(end,1),1);
  set(handles.BehaviorList,'Value',handles.behaviorvalue);
  set(handles.BehaviorLogic,'Value',1);
  set(handles.BehaviorList2,'enable','off');
  handles.featurevalue=handles.table_data(eventdata.Indices(end,1),2);
  set(handles.FeatureList,'Value',handles.featurevalue);
  handles.individual=1;
  set(handles.IndividualList,'Value',handles.individual);

  if(strcmp(handles.table,'timeseries'))
    handles.timeseries_timing=handles.table_data(eventdata.Indices(end,1),3);
    FeatureTimeSeries_Callback(hObject, eventdata, handles);

  elseif(strcmp(handles.table,'histogram'))
    FeatureHistogram_Callback(hObject, eventdata, handles);
  end
end

guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuTimeSeries_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function MenuTimeSeriesTiming_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesTiming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function MenuTimeSeriesStatistic_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesStatistic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function MenuTimeSeriesSubtractMean_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesSubtractMean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.timeseries_subtractmean=~handles.timeseries_subtractmean;
if(handles.timeseries_subtractmean)
  set(handles.MenuTimeSeriesSubtractMean,'Checked','on');
else
  set(handles.MenuTimeSeriesSubtractMean,'Checked','off');
end
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuTimeSeriesRadius_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.timeseries_windowradius=str2num(char(inputdlg({'Window radius:'},'',1,{num2str(10)})));
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuTimeSeriesTight_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesTight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.timeseries_tight=~handles.timeseries_tight;
if(handles.timeseries_tight)
  set(handles.MenuTimeSeriesTight,'Checked','on');
else
  set(handles.MenuTimeSeriesTight,'Checked','off');
end
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuTimeSeriesTimingOnset_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesTimingOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.timeseries_timing=1;
set(handles.MenuTimeSeriesTimingOnset,'Checked','on');
set(handles.MenuTimeSeriesTimingOffset,'Checked','off');
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuTimeSeriesTimingOffset_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesTimingOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.timeseries_timing=2;
set(handles.MenuTimeSeriesTimingOnset,'Checked','off');
set(handles.MenuTimeSeriesTimingOffset,'Checked','on');
guidata(hObject,handles);


% ---
function menu_timeseries_statistic_set(arg)

handles=guidata(gcf);

set(handles.MenuTimeSeriesStatisticMean,'Checked','off');
set(handles.MenuTimeSeriesStatisticMeanDeviation,'Checked','off');
set(handles.MenuTimeSeriesStatisticMeanStdErr,'Checked','off');
set(handles.MenuTimeSeriesStatisticMedian,'Checked','off');
set(handles.MenuTimeSeriesStatisticMedian5,'Checked','off');
set(handles.MenuTimeSeriesStatisticMedian25,'Checked','off');
switch(arg)
  case(1), set(handles.MenuTimeSeriesStatisticMean,'Checked','on');
  case(2), set(handles.MenuTimeSeriesStatisticMeanDeviation,'Checked','on');
  case(3), set(handles.MenuTimeSeriesStatisticMeanStdErr,'Checked','on');
  case(4), set(handles.MenuTimeSeriesStatisticMedian,'Checked','on');
  case(5), set(handles.MenuTimeSeriesStatisticMedian5,'Checked','on');
  case(6), set(handles.MenuTimeSeriesStatisticMedian25,'Checked','on');
end


% --------------------------------------------------------------------
function MenuTimeSeriesStatisticMean_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesStatisticMean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.timeseries_statistic=1;
menu_timeseries_statistic_set(handles.timeseries_statistic);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuTimeSeriesStatisticMeanDeviation_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesStatisticMeanDeviation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.timeseries_statistic=2;
menu_timeseries_statistic_set(handles.timeseries_statistic);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuTimeSeriesStatisticMeanStdErr_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesStatisticMeanStdErr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.timeseries_statistic=3;
menu_timeseries_statistic_set(handles.timeseries_statistic);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuTimeSeriesStatisticMedian_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesStatisticMedian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.timeseries_statistic=4;
menu_timeseries_statistic_set(handles.timeseries_statistic);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuTimeSeriesStatisticMedian5_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesStatisticMedian5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.timeseries_statistic=5;
menu_timeseries_statistic_set(handles.timeseries_statistic);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuTimeSeriesStatisticMedian25_Callback(hObject, eventdata, handles)
% hObject    handle to MenuTimeSeriesStatisticMedian25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.timeseries_statistic=6;
menu_timeseries_statistic_set(handles.timeseries_statistic);
guidata(hObject,handles);


% ---
function menu_histogram_set(arg)

handles=guidata(gcf);

set(handles.MenuHistogramPerFrame,'Checked','off');
set(handles.MenuHistogramMeanPerBout,'Checked','off');
set(handles.MenuHistogramMedianPerBout,'Checked','off');
set(handles.MenuHistogramMaxPerBout,'Checked','off');
set(handles.MenuHistogramMinPerBout,'Checked','off');
set(handles.MenuHistogramStdPerBout,'Checked','off');
switch(arg)
  case(1), set(handles.MenuHistogramPerFrame,'Checked','on');
  case(2), set(handles.MenuHistogramMeanPerBout,'Checked','on');
  case(3), set(handles.MenuHistogramMedianPerBout,'Checked','on');
  case(4), set(handles.MenuHistogramMaxPerBout,'Checked','on');
  case(5), set(handles.MenuHistogramMinPerBout,'Checked','on');
  case(6), set(handles.MenuHistogramStdPerBout,'Checked','on');
end


% --------------------------------------------------------------------
function MenuHistogramPerFrame_Callback(hObject, eventdata, handles)
% hObject    handle to MenuHistogramPerFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.histogram_perwhat=1;
menu_histogram_set(handles.histogram_perwhat);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuHistogramMeanPerBout_Callback(hObject, eventdata, handles)
% hObject    handle to MenuHistogramMeanPerBout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.histogram_perwhat=2;
menu_histogram_set(handles.histogram_perwhat);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuHistogramMedianPerBout_Callback(hObject, eventdata, handles)
% hObject    handle to MenuHistogramMedianPerBout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.histogram_perwhat=3;
menu_histogram_set(handles.histogram_perwhat);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuHistogramMaxPerBout_Callback(hObject, eventdata, handles)
% hObject    handle to MenuHistogramMaxPerBout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.histogram_perwhat=4;
menu_histogram_set(handles.histogram_perwhat);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuHistogramMinPerBout_Callback(hObject, eventdata, handles)
% hObject    handle to MenuHistogramMinPerBout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.histogram_perwhat=5;
menu_histogram_set(handles.histogram_perwhat);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuHistogramStdPerBout_Callback(hObject, eventdata, handles)
% hObject    handle to MenuHistogramStdPerBout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.histogram_perwhat=6;
menu_histogram_set(handles.histogram_perwhat);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to MenuHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% ---
function menu_boutstats_set(arg)

handles=guidata(gcf);

set(handles.MenuBoutStatsMean,'Checked','off');
set(handles.MenuBoutStatsMeanDeviation,'Checked','off');
set(handles.MenuBoutStatsMeanStdError,'Checked','off');
set(handles.MenuBoutStatsMedian,'Checked','off');
set(handles.MenuBoutStatsMedian5,'Checked','off');
set(handles.MenuBoutStatsMedian25,'Checked','off');
switch(arg)
  case(1), set(handles.MenuBoutStatsMean,'Checked','on');
  case(2), set(handles.MenuBoutStatsMeanDeviation,'Checked','on');
  case(3), set(handles.MenuBoutStatsMeanStdError,'Checked','on');
  case(4), set(handles.MenuBoutStatsMedian,'Checked','on');
  case(5), set(handles.MenuBoutStatsMedian5,'Checked','on');
  case(6), set(handles.MenuBoutStatsMedian25,'Checked','on');
end


% --------------------------------------------------------------------
function MenuBoutStatsMean_Callback(hObject, eventdata, handles)
% hObject    handle to MenuBoutStatsMean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.boutstats=1;
menu_boutstats_set(handles.boutstats);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuBoutStatsMeanDeviation_Callback(hObject, eventdata, handles)
% hObject    handle to MenuBoutStatsMeanDeviation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.boutstats=2;
menu_boutstats_set(handles.boutstats);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuBoutStatsMeanStdError_Callback(hObject, eventdata, handles)
% hObject    handle to MenuBoutStatsMeanStdError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.boutstats=3;
menu_boutstats_set(handles.boutstats);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuBoutStatsMedian_Callback(hObject, eventdata, handles)
% hObject    handle to MenuBoutStatsMedian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.boutstats=4;
menu_boutstats_set(handles.boutstats);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuBoutStatsMedian5_Callback(hObject, eventdata, handles)
% hObject    handle to MenuBoutStatsMedian5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.boutstats=5;
menu_boutstats_set(handles.boutstats);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuBoutStatsMedian25_Callback(hObject, eventdata, handles)
% hObject    handle to MenuBoutStatsMedian25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.boutstats=6;
menu_boutstats_set(handles.boutstats);
guidata(hObject,handles);


% --------------------------------------------------------------------
function MenuBoutStats_Callback(hObject, eventdata, handles)
% hObject    handle to MenuBoutStats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Zoom.
function Zoom_Callback(hObject, eventdata, handles)
% hObject    handle to Zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h=zoom(gcf);
if(strcmp(get(h,'enable'),'off'))
  zoom on;
  pan off;
  set(handles.Zoom,'backgroundcolor',0.4*[1 1 1]);
  set(handles.Pan,'backgroundcolor',get(gcf,'color'));
else
  zoom off;
  pan off;
  set(handles.Zoom,'backgroundcolor',get(gcf,'color'));
end


% --- Executes on button press in Pan.
function Pan_Callback(hObject, eventdata, handles)
% hObject    handle to Pan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h=pan(gcf);
if(strcmp(get(h,'enable'),'off'))
  pan on;
  zoom off;
  set(handles.Pan,'backgroundcolor',0.4*[1 1 1]);
  set(handles.Zoom,'backgroundcolor',get(gcf,'color'));
else
  pan off;
  zoom off;
  set(handles.Pan,'backgroundcolor',get(gcf,'color'));
end


% --- Executes on button press in LogY.
function LogY_Callback(hObject, eventdata, handles)
% hObject    handle to LogY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.logy=~handles.logy;
h=get(gca,'yscale');
if(handles.logy)
  set(gca,'yscale','log');
  set(handles.LogY,'backgroundcolor',0.4*[1 1 1]);
else
  set(gca,'yscale','linear');
  set(handles.LogY,'backgroundcolor',get(gcf,'color'));
end
guidata(hObject, handles);


% --- Executes on button press in Stats.
function Stats_Callback(hObject, eventdata, handles)
% hObject    handle to Stats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.stats=~handles.stats;
h=findobj('tag','stats');
if(handles.stats)
  set(h,'visible','on');
  set(handles.Stats,'backgroundcolor',0.4*[1 1 1]);
else
  set(h,'visible','off');
  set(handles.Stats,'backgroundcolor',get(gcf,'color'));
end
guidata(hObject, handles);
