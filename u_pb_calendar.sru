$PBExportHeader$u_pb_calendar.sru
$PBExportComments$userobject for all powerbuilder pop-up calendar
forward
global type u_pb_calendar from UserObject
end type
type cb_1 from commandbutton within u_pb_calendar
end type
type st_11 from statictext within u_pb_calendar
end type
type st_10 from statictext within u_pb_calendar
end type
type cb_close from commandbutton within u_pb_calendar
end type
type cb_help from commandbutton within u_pb_calendar
end type
type mle_1 from statictext within u_pb_calendar
end type
type st_9 from statictext within u_pb_calendar
end type
type st_8 from statictext within u_pb_calendar
end type
type st_7 from statictext within u_pb_calendar
end type
type st_6 from statictext within u_pb_calendar
end type
type st_4 from statictext within u_pb_calendar
end type
type st_3 from statictext within u_pb_calendar
end type
type st_2 from statictext within u_pb_calendar
end type
type st_1 from statictext within u_pb_calendar
end type
type cb_forwardyear from commandbutton within u_pb_calendar
end type
type cb_backyear from commandbutton within u_pb_calendar
end type
type cb_forwardmonth from commandbutton within u_pb_calendar
end type
type cb_backmonth from commandbutton within u_pb_calendar
end type
type dw_cal from datawindow within u_pb_calendar
end type
type ln_1 from line within u_pb_calendar
end type
type ln_2 from line within u_pb_calendar
end type
end forward

shared variables
string s_selected_date
end variables

global type u_pb_calendar from UserObject
int Width=2523
int Height=1066
long BackColor=80263328
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event ue_close ( )
cb_1 cb_1
st_11 st_11
st_10 st_10
cb_close cb_close
cb_help cb_help
mle_1 mle_1
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_forwardyear cb_forwardyear
cb_backyear cb_backyear
cb_forwardmonth cb_forwardmonth
cb_backmonth cb_backmonth
dw_cal dw_cal
ln_1 ln_1
ln_2 ln_2
end type
global u_pb_calendar u_pb_calendar

type variables
Int ii_Day, ii_Month, ii_Year
String is_old_column
String is_DateFormat
Date id_date_selected
string is_return_date
window i_window
object i_obj

dwobject i_dwo
datawindow i_dw
singlelineedit i_sle
multilineedit i_mle
statictext i_st
editmask i_em
dropdownlistbox i_ddlb
richtextedit i_rte

string dateparm

//string s_selected_date
end variables

forward prototypes
public function integer days_in_month (integer month, integer year)
public subroutine draw_month (integer year, integer month)
public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month)
public function int get_month_number (string as_month)
public function string get_month_string (int as_month)
public subroutine init_cal (date ad_start_date)
public function integer unhighlight_column (string as_column)
public subroutine set_date (date ad_date)
public subroutine set_date_format (string as_date_format)
public function integer highlight_column (string as_column)
end prototypes

event ue_close;close(i_window)
end event

public function integer days_in_month (integer month, integer year);//Most cases are straight forward in that there are a fixed number of 
//days in 11 of the 12 months.  February is, of course, the problem.
//In a leap year February has 29 days, otherwise 28.

Integer		li_DaysInMonth, li_Days[12] = {31,28,31,30,31,30,31,31,30,31,30,31}

// Get the number of days per month for a non leap year.
li_DaysInMonth = li_Days[Month]

// Check for a leap year.
If Month = 2 Then
	// If the year is a leap year, change the number of days.
	// Leap Year Calculation:
	//	Year divisible by 4, but not by 100, unless it is also divisible by 400
	If ( (Mod(Year,4) = 0 And Mod(Year,100) <> 0) Or (Mod(Year,400) = 0) ) Then
		li_DaysInMonth = 29
	End If
End If

//Return the number of days in the relevant month
Return li_DaysInMonth

end function

public subroutine draw_month (integer year, integer month);Int  li_FirstDayNum, li_cell, li_daysinmonth
Date ld_firstday
String ls_month, ls_cell, ls_return

//Set Pointer to an Hourglass and turn off redrawing of Calendar
SetPointer(Hourglass!)
SetRedraw(dw_cal,FALSE)

//Set Instance variables to arguments
ii_month = month
ii_year = year

//check in the instance day is valid for month/year 
//back the day down one if invalid for month ie 31 will become 30
Do While Date(ii_year,ii_month,ii_day) = Date(00,1,1)
	ii_day --
Loop

//Work out how many days in the month
li_daysinmonth = days_in_month(ii_month,ii_year)

//Find the date of the first day in the month
ld_firstday = Date(ii_year,ii_month,1)

//Find what day of the week this is
li_FirstDayNum = DayNumber(ld_firstday)

//Set the first cell
li_cell = li_FirstDayNum + ii_day - 1

//If there was an old column turn off the highlight
unhighlight_column (is_old_column)

//Set the Title
ls_month = get_month_string(ii_month) + " " + string(ii_year)
dw_cal.Object.st_month.text = ls_month

//Enter the day numbers into the datawindow
enter_day_numbers(li_FirstDayNum,li_daysinmonth)

//Define the current cell name
ls_cell = 'cell'+string(li_cell)

//Highlight the current date
highlight_column (ls_cell)

//Set the old column for next time
is_old_column = ls_cell

//Reset the pointer and Redraw
SetPointer(Arrow!)
dw_cal.SetRedraw(TRUE)

end subroutine

public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month);Int li_count, li_daycount

//Blank the columns before the first day of the month
For li_count = 1 to ai_start_day_num
	dw_cal.SetItem(1,li_count,"")
Next

//Set the columns for the days to the String of their Day number
For li_count = 1 to ai_days_in_month
	//Use li_daycount to find which column needs to be set
	li_daycount = ai_start_day_num + li_count - 1
	dw_cal.SetItem(1,li_daycount,String(li_count))
Next

//Move to next column
li_daycount = li_daycount + 1

//Blank remainder of columns
For li_count = li_daycount to 42
	dw_cal.SetItem(1,li_count,"")
Next

//If there was an old column turn off the highlight
unhighlight_column (is_old_column)

is_old_column = ''


end subroutine

public function int get_month_number (string as_month);Int li_month_number

CHOOSE CASE as_month
	CASE "Jan"
		li_month_number = 1
	CASE "Feb"
		li_month_number = 2
	CASE "Mar"
		li_month_number = 3
	CASE "Apr"
		li_month_number = 4
	CASE "May"
		li_month_number = 5
	CASE "Jun"
		li_month_number = 6
	CASE "Jul"
		li_month_number = 7
	CASE "Aug"
		li_month_number = 8
	CASE "Sep"
		li_month_number = 9
	CASE "Oct"
		li_month_number = 10
	CASE "Nov"
		li_month_number = 11
	CASE "Dec"
		li_month_number = 12
END CHOOSE

return li_month_number
end function

public function string get_month_string (int as_month);String ls_month

CHOOSE CASE as_month
	CASE 1
		ls_month = "January"
	CASE 2
		ls_month = "February"
	CASE 3
		ls_month = "March"
	CASE 4
		ls_month = "April"
	CASE 5
		ls_month = "May"
	CASE 6
		ls_month = "June"
	CASE 7
		ls_month = "July"
	CASE 8
		ls_month = "August"
	CASE 9
		ls_month = "September"
	CASE 10
		ls_month = "October"
	CASE 11
		ls_month = "November"
	CASE 12
		ls_month = "December"
END CHOOSE

return ls_month
end function

public subroutine init_cal (date ad_start_date);
/* code added to allow key-scrolling thru month; minimize redraw actions when staying within same month */

Int li_FirstDayNum, li_Cell, li_DaysInMonth
String ls_Year, ls_Month, ls_Return, ls_Cell
Date ld_FirstDay
boolean lb_redraw_month

dw_cal.SetRedraw(FALSE)

// unhighlight the previous cell
if len(is_old_column) > 0 then
   unhighlight_column (is_old_column)
end if

//Set the variables for Day, Month and Year from the date passed to
//the function

if dw_cal.Rowcount() = 1 and ii_month > 0 and ii_month = Month(ad_start_date) and ii_year > 0 and ii_year = Year(ad_start_date) then // same month; don't redraw
else
   ii_Month = Month(ad_start_date)
   ii_Year = Year(ad_start_date)
	//Reset the datawindow
   reset(dw_cal)
   //Insert a row into the script datawindow
   dw_cal.InsertRow(0)
   lb_redraw_month = TRUE
end if
ii_Day = Day(ad_start_date)

//Find how many days in the relevant month
li_daysinmonth = days_in_month(ii_month, ii_year)

//Find the date of the first day of this month
ld_FirstDay = Date(ii_Year, ii_month, 1)

//What day of the week is the first day of the month
li_FirstDayNum = DayNumber(ld_FirstDay)

//Set the starting "cell" in the datawindow. i.e the column in which
//the first day of the month will be displayed
li_Cell = li_FirstDayNum + ii_Day - 1

if lb_redraw_month then
   //Set the Title of the calendar with the Month and Year
   ls_Month = get_month_string(ii_Month) + " " + string(ii_Year)
   dw_cal.Object.st_month.text = ls_month

   //Enter the numbers of the days
   enter_day_numbers(li_FirstDayNum, li_DaysInMonth)
end if

dw_cal.SetItem(1,li_cell,String(Day(ad_start_date)))

//Define the first Cell as a string
ls_cell = 'cell'+string(li_cell)

//Display the first day in bold (or 3D)
highlight_column (ls_cell)

//Set the instance variable i_old_column to hold the current cell, so
//when we change it, we know the old setting
is_old_column = ls_Cell

dw_cal.SetRedraw(TRUE)
dw_cal.setfocus()

end subroutine

public function integer unhighlight_column (string as_column);//If the highlight is on the column set the border of the column back to normal

string ls_return

If as_column <> '' then
	ls_return = dw_cal.Modify(as_column + ".border=0")
	If ls_return <> "" then 
		MessageBox("Modify",ls_return)
		Return -1
	End if
End If

Return 1
end function

public subroutine set_date (date ad_date);// Set the date.  Use the desired format.

If Not isnull(ad_date) then 
	is_return_date = string(ad_date, 'mm/dd/yyyy')
End If
end subroutine

public subroutine set_date_format (string as_date_format);// Set the format.
is_DateFormat = as_date_format

// Set the date with the new format.
If Not isnull(id_date_selected) then 
	set_date (id_date_selected)
End If
end subroutine

public function integer highlight_column (string as_column);//Highlight the current column/date

string ls_return

ls_return = dw_cal.Modify(as_column + ".border=5")
If ls_return <> "" then 
	MessageBox("Modify",ls_return)
	Return -1
End if

Return 1
end function

event constructor;// Get the powerobject parameter...
i_obj = message.powerobjectparm.typeof()

CHOOSE CASE i_obj
	CASE DWObject!
		i_dwo = message.powerobjectparm
		dateparm = string(i_dwo.primary[1],'mm/dd/yyyy')
		//messagebox('',dateparm)  // for you to debug what's coming in
	CASE DropDownListBox!
		i_ddlb = message.powerobjectparm
		dateparm = i_ddlb.text
	CASE RichTextEdit!
		i_rte = message.powerobjectparm
		dateparm = i_rte.textline()
	CASE SingleLineEdit!
		i_sle = message.powerobjectparm
		dateparm = i_sle.text
	CASE MultiLineEdit!
		i_mle = message.powerobjectparm
		dateparm = i_mle.text
	CASE StaticText!
		i_st = message.powerobjectparm
		dateparm = i_st.text
	CASE EditMask!
		i_em = message.powerobjectparm
		dateparm = i_em.text
	CASE ELSE
		// The object Is irrelevant!
		CloseWithReturn(i_window,dateparm)
END CHOOSE

this.width = dw_cal.width
this.height = dw_cal.height
mle_1.width = dw_cal.width - 25
mle_1.height = dw_cal.height - 20
mle_1.visible = false

if not isdate(dateparm) or trim(dateparm) = '00/00/00' or trim(dateparm) = '' or isnull(dateparm) then
	id_date_selected = today()
	ii_day = day(id_date_selected)
	ii_month = month(id_date_selected)
	ii_year = year(id_date_selected)
else
	if date(dateparm) = 1900-01-01 or isnull(date(dateparm)) then 
		messagebox('Date Parameter','The date passed to this window is invalid.')
		this.postevent(close!)
		return
	end if
	ii_day = day(date(dateparm))
	ii_month = month(date(dateparm))
	ii_year = year(date(dateparm))
end if


// If there is already a date in the edit box then make this the
// current date in the calendar, otherwise use today
If ii_day = 0 Then ii_day = 1
//ld_date = date(ii_year, ii_month, ii_day)  // This line used for debugging
init_cal(date(ii_year, ii_month, ii_day))


end event

on u_pb_calendar.create
this.cb_1=create cb_1
this.st_11=create st_11
this.st_10=create st_10
this.cb_close=create cb_close
this.cb_help=create cb_help
this.mle_1=create mle_1
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_forwardyear=create cb_forwardyear
this.cb_backyear=create cb_backyear
this.cb_forwardmonth=create cb_forwardmonth
this.cb_backmonth=create cb_backmonth
this.dw_cal=create dw_cal
this.ln_1=create ln_1
this.ln_2=create ln_2
this.Control[]={this.cb_1,&
this.st_11,&
this.st_10,&
this.cb_close,&
this.cb_help,&
this.mle_1,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_forwardyear,&
this.cb_backyear,&
this.cb_forwardmonth,&
this.cb_backmonth,&
this.dw_cal,&
this.ln_1,&
this.ln_2}
end on

on u_pb_calendar.destroy
destroy(this.cb_1)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.cb_close)
destroy(this.cb_help)
destroy(this.mle_1)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_forwardyear)
destroy(this.cb_backyear)
destroy(this.cb_forwardmonth)
destroy(this.cb_backmonth)
destroy(this.dw_cal)
destroy(this.ln_1)
destroy(this.ln_2)
end on

type cb_1 from commandbutton within u_pb_calendar
int X=245
int Y=560
int Width=256
int Height=64
int TabOrder=80
string Text="No Date"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CHOOSE CASE i_obj
	CASE DWObject!
		// the user must do a SetItem after the OpenWithParm using the message.stringparm
		//i_dwo.primary[1] = id_date_selected
	CASE DropDownListBox!
		i_ddlb.text = ""
	CASE RichTextEdit!
		//i_rte.textline()
	CASE SingleLineEdit!
		setnull(i_sle.text)
	CASE MultiLineEdit!
		setnull(i_mle.text)
	CASE StaticText!
		setnull(i_st.text)
	CASE EditMask!
		setnull(i_em.text)
	CASE ELSE
		MessageBox("Error","Unidentified object.  Add to u_pb_calendar constructor and clicked for dw_cal events and add a new uo_1 instance variable type.")
END CHOOSE


close(i_window)
end event

type st_11 from statictext within u_pb_calendar
int X=878
int Y=858
int Width=1635
int Height=192
boolean Enabled=false
string Text="10) DEVELOPMENT BUG!  YOU MAY HAVE TO OPEN W_PB_CALENDAR ONE TIME TO LET PB KNOW ABOUT THE LOCAL EXTERNAL FUNCTION!  Open Local External Function, hit OK, then Save the window."
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_10 from statictext within u_pb_calendar
int X=878
int Y=784
int Width=1682
int Height=77
boolean Enabled=false
string Text="9) You may want to code your object to open this upon keying CTRL+D."
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within u_pb_calendar
event clicked pbm_bnclicked
int X=600
int Y=560
int Width=84
int Height=64
int TabOrder=70
string Text="x"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(i_window)
end event

type cb_help from commandbutton within u_pb_calendar
int X=512
int Y=560
int Width=84
int Height=64
int TabOrder=60
string Text="?"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;mle_1.visible = true
dw_cal.setfocus()
end event

type mle_1 from statictext within u_pb_calendar
int Width=51
int Height=64
string Text="Press F1 or right-click when finished with this help.  Navigate by clicking on a day or use the keys PgUp, PgDn, CTRL+PgUP, CTRL+PgDn, and the four arrow keys.  Hit ESC to not select a date. Click on a day or hit ENTER to accept a selected date."
boolean FocusRectangle=false
long BackColor=65535
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event rbuttondown;this.visible = false

return 1

end event

type st_9 from statictext within u_pb_calendar
int X=878
int Y=714
int Width=1605
int Height=77
boolean Enabled=false
string Text="8) Use PageUp, PageDown, and the 4 arrow keys, and Enter to select."
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within u_pb_calendar
int X=878
int Y=640
int Width=1605
int Height=77
boolean Enabled=false
string Text="7) Returns with a string(date) in the message.stringparm object."
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within u_pb_calendar
int X=878
int Y=570
int Width=1605
int Height=77
boolean Enabled=false
string Text="6) User can hit escape to close the calendar.  The original date remains."
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within u_pb_calendar
int X=878
int Y=496
int Width=1657
int Height=77
boolean Enabled=false
string Text="5) Defaults to today() if the parameter is an invalid date (zeros)"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within u_pb_calendar
int X=878
int Y=310
int Width=1712
int Height=198
boolean Enabled=false
string Text=" 4) 1 line of code:  OpenWithParm(w_pb_calendar,this).  For DW's you will have to SetItem after the Open.  See the w_pb_calendar open event to copy script."
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within u_pb_calendar
int X=878
int Y=186
int Width=1624
int Height=118
boolean Enabled=false
string Text="3)  The response window resizes to be the size of the uo_1 so don't resize anything here either!"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_pb_calendar
int X=878
int Y=77
int Width=1715
int Height=122
boolean Enabled=false
string Text="2)  This visual object resizes to be the size of the dw so don't change anything!"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_pb_calendar
int X=878
int Y=16
int Width=1419
int Height=77
boolean Enabled=false
string Text="1)  Uses Courier for the arrows.  User must have font installed. "
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_forwardyear from commandbutton within u_pb_calendar
event _keydown pbm_keydown
int X=633
int Width=77
int Height=86
int TabOrder=30
string Text=">"
int TextSize=-15
int Weight=700
string FaceName="Courier"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

event _keydown;dw_cal.setfocus()
dw_cal.triggerevent(key!)

end event

event clicked;//Increment the month number, but if its 13, set back to 1 (January)
//ii_month = ii_month + 1
//If ii_month = 13 then
//	ii_month = 1
ii_year = ii_year + 1
//End If

//check if selected day is no longer valid for new month
If not(isdate(string(ii_month) + "/" + string(ii_day) + "/"+ string(ii_year))) Then ii_day = 1
	
//Draw the month
draw_month ( ii_year, ii_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year,ii_month,ii_Day)
set_date (id_date_selected)
dw_cal.setfocus()
end event

type cb_backyear from commandbutton within u_pb_calendar
event _keydown pbm_keydown
int Width=77
int Height=86
int TabOrder=20
string Text="<"
int TextSize=-15
int Weight=700
string FaceName="Courier"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

event _keydown;dw_cal.setfocus()
dw_cal.triggerevent(key!)

end event

event clicked;//Decrement the month, if 0, set to 12 (December)
//ii_month = ii_month - 1
//If ii_month = 0 then
//	ii_month = 12
ii_year = ii_year - 1
//End If

//check if selected day is no longer valid for new month
If not(isdate(string(ii_month) + "/" + string(ii_day) + "/"+ string(ii_year))) Then ii_day = 1

//Draw the month
draw_month ( ii_year, ii_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year,ii_month,ii_Day)
set_date (id_date_selected)

dw_cal.setfocus()
end event

type cb_forwardmonth from commandbutton within u_pb_calendar
event _keydown pbm_keydown
int X=581
int Width=51
int Height=86
int TabOrder=50
string Text=">"
int TextSize=-8
int Weight=400
string FaceName="Courier"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

event _keydown;dw_cal.setfocus()
dw_cal.triggerevent(key!)

end event

event clicked;//Increment the month number, but if its 13, set back to 1 (January)
ii_month = ii_month + 1
If ii_month = 13 then
	ii_month = 1
	ii_year = ii_year + 1
End If

//check if selected day is no longer valid for new month
If not(isdate(string(ii_month) + "/" + string(ii_day) + "/"+ string(ii_year))) Then ii_day = 1
	
//Draw the month
draw_month ( ii_year, ii_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year,ii_month,ii_Day)
set_date (id_date_selected)
dw_cal.setfocus()
end event

type cb_backmonth from commandbutton within u_pb_calendar
event _keydown pbm_keydown
int X=77
int Width=51
int Height=86
int TabOrder=40
string Text="<"
int TextSize=-8
int Weight=400
string FaceName="Courier"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

event _keydown;dw_cal.setfocus()
dw_cal.triggerevent(key!)

end event

event clicked;//Decrement the month, if 0, set to 12 (December)
ii_month = ii_month - 1
If ii_month = 0 then
	ii_month = 12
	ii_year = ii_year - 1
End If

//check if selected day is no longer valid for new month
If not(isdate(string(ii_month) + "/" + string(ii_day) + "/"+ string(ii_year))) Then ii_day = 1

//Darw the month
draw_month ( ii_year, ii_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year,ii_month,ii_Day)
set_date (id_date_selected)
dw_cal.setfocus()
end event

type dw_cal from datawindow within u_pb_calendar
event ue_dwnkey pbm_dwnkey
int Width=739
int Height=656
int TabOrder=10
string DataObject="d_calendar"
boolean Border=false
end type

event ue_dwnkey;
/*This script will allow the ctrl right arrow and
  ctrl left arrow key combinations to change the months on
  the calendar;
  7/15/97 Mods by REB; arrow keys move within month;
  shift arrow move between months;
  control key arrow move between years;
  cells go from cell1 to cell42;
*/

string ls_columnname
integer li
dwobject dwo


choose case true
	case keydown(keyEnter!) // return the date
		  CHOOSE CASE is_old_column
   			CASE 'cell1'
					dwo = this.Object.cell1
   			CASE 'cell2'
					dwo = this.Object.cell2
   			CASE 'cell3'
	   			dwo = this.Object.cell3
   			CASE 'cell4'
	   			dwo = this.Object.cell4
   			CASE 'cell5'
	   			dwo = this.Object.cell5
   			CASE 'cell6'
	   			dwo = this.Object.cell6
   			CASE 'cell7'
	   			dwo = this.Object.cell7
   			CASE 'cell8'
	   			dwo = this.Object.cell8
   			CASE 'cell9'
	   			dwo = this.Object.cell9
   			CASE 'cell10'
	   			dwo = this.Object.cell10
   			CASE 'cell11'
	   			dwo = this.Object.cell11
   			CASE 'cell12'
	   			dwo = this.Object.cell12
   			CASE 'cell13'
	   			dwo = this.Object.cell13
   			CASE 'cell14'
	   			dwo = this.Object.cell14
   			CASE 'cell15'
	   			dwo = this.Object.cell15
   			CASE 'cell16'
	   			dwo = this.Object.cell16
   			CASE 'cell17'
	   			dwo = this.Object.cell17
   			CASE 'cell18'
	   			dwo = this.Object.cell18
   			CASE 'cell19'
	   			dwo = this.Object.cell19
   			CASE 'cell20'
	   			dwo = this.Object.cell20
   			CASE 'cell21'
	   			dwo = this.Object.cell21
   			CASE 'cell22'
	   			dwo = this.Object.cell22
   			CASE 'cell23'
	   			dwo = this.Object.cell23
   			CASE 'cell24'
	   			dwo = this.Object.cell24
   			CASE 'cell25'
	   			dwo = this.Object.cell25
   			CASE 'cell26'
	   			dwo = this.Object.cell26
   			CASE 'cell27'
	   			dwo = this.Object.cell27
   			CASE 'cell28'
	   			dwo = this.Object.cell28
   			CASE 'cell29'
	   			dwo = this.Object.cell29
   			CASE 'cell30'
	   			dwo = this.Object.cell30
   			CASE 'cell31'
	   			dwo = this.Object.cell31
   			CASE 'cell32'
	   			dwo = this.Object.cell32
   			CASE 'cell33'
	   			dwo = this.Object.cell33
   			CASE 'cell34'
	   			dwo = this.Object.cell34
   			CASE 'cell35'
	   			dwo = this.Object.cell35
   			CASE 'cell36'
	   			dwo = this.Object.cell36
   			CASE 'cell37'
	   			dwo = this.Object.cell37
   			CASE 'cell38'
	   			dwo = this.Object.cell38
   			CASE 'cell39'
	   			dwo = this.Object.cell39
   			CASE 'cell40'
	   			dwo = this.Object.cell40
   			CASE 'cell41'
	   			dwo = this.Object.cell41
   			CASE 'cell42'
	   			dwo = this.Object.cell42
				CASE ELSE
					return
		  END CHOOSE
  		  this.Event post clicked(1, 1, 1, dwo)
	case keydown(keyControl!) and (keydown(keyLeftArrow!) or keydown(keyPageDown!))
		cb_backyear.triggerevent(clicked!)
	case keydown(keyControl!) and (keydown(keyRightArrow!) or keydown(keyPageUp!))
		cb_forwardyear.triggerevent(clicked!)
	case (keydown(keyShift!) and keydown(keyLeftArrow!)) or keydown(keyPageDown!)
		cb_backmonth.triggerevent(clicked!)
	case (keydown(keyShift!) and keydown(keyRightArrow!)) or keydown(keyPageUp!)
		cb_forwardmonth.triggerevent(clicked!)
	case keydown(keyRightArrow!)
		init_cal(RelativeDate(date(ii_year, ii_month, ii_day), 1) )
	case keydown(keyLeftArrow!)
		init_cal(RelativeDate(date(ii_year, ii_month, ii_day), - 1) )
	case keydown(keyUpArrow!)
		init_cal(RelativeDate(date(ii_year, ii_month, ii_day), - 7) )
	case keydown(keyDownArrow!)
		init_cal(RelativeDate(date(ii_year, ii_month, ii_day), 7 ) )
	case keydown(keyF1!)
		mle_1.visible = not mle_1.visible
end choose
end event

event clicked;String ls_clickedcolumn, ls_clickedcolumnID
String ls_day, ls_return
string ls_col_name

//Return if click was not on a valid dwobject, depending on what was
//clicked, dwo will be null or dwo.name will be "datawindow"
If IsNull(dwo) Then Return
If Pos(dwo.name, "cell") = 0 Then Return

//Find which column was clicked on and return if it is not valid
ls_clickedcolumn = dwo.name
ls_clickedcolumnID = dwo.id
If ls_clickedcolumn = '' Then Return

//Set Day to the text of the clicked column. Return if it is an empty column
ls_day = dwo.primary[1]
If ls_day = "" then Return

//Convert to a number and place in Instance variable
ii_day = Integer(ls_day)

//If the highlight was on a previous column (is_old_column <> '')
//set the border of the old column back to normal
unhighlight_column (is_old_column)

//Highlight chosen day/column
dwo.border = 5

//Set the old column for next time
is_old_column = ls_clickedcolumn

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year, ii_month, ii_Day)
set_date (id_date_selected)

// set the object to be the date selected
CHOOSE CASE i_obj
	CASE DWObject!
		// the user must do a SetItem after the OpenWithParm using the message.stringparm
		//i_dwo.primary[1] = id_date_selected
	CASE DropDownListBox!
		i_ddlb.text = string(id_date_selected,'mm/dd/yyyy')
	CASE RichTextEdit!
		//i_rte.textline()
	CASE SingleLineEdit!
		i_sle.text = string(id_date_selected,'mm/dd/yyyy')
	CASE MultiLineEdit!
		i_mle.text = string(id_date_selected,'mm/dd/yyyy')
	CASE StaticText!
		i_st.text = string(id_date_selected,'mm/dd/yyyy')
	CASE EditMask!
		i_em.text = string(id_date_selected,'mm/dd/yyyy')
	CASE ELSE
		MessageBox("Error","Unidentified object.  Add to u_pb_calendar constructor and clicked for dw_cal events and add a new uo_1 instance variable type.")
END CHOOSE


//closewithreturn(i_window,string(id_date_selected, 'mm/dd/yyyy'))
close(i_window)
end event

type ln_1 from line within u_pb_calendar
boolean Enabled=false
int BeginY=678
int EndX=837
int EndY=678
int LineThickness=6
long LineColor=16777215
end type

type ln_2 from line within u_pb_calendar
boolean Enabled=false
int BeginX=834
int EndX=834
int EndY=678
int LineThickness=6
long LineColor=16777215
end type

