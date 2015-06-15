
function ShowCurrentMonthYear()
{
	document.getElementById("monthYear").innerHTML = "Tháng " + (today.getMonth() + 1) + " Năm " + today.getFullYear(); 
}

function ShowCurrentDay()
{
	document.getElementById("date").innerHTML = "" + today.getDate();
}

function ShowDayofWeek()
{
	var dayofWeek = TUAN[(currentLunarDate.jd+1) % 7 ];
		
	document.getElementById("dayofWeek").innerHTML = "" + dayofWeek;
}

function findIndexofTable(emptyCells, currentMonth, date)
{
	for (i=0; i<6 ; i++)
		for (j=0; j<7 ;j ++)
		{
			k = 7 * i + j;
			
			if (k < emptyCells || k>= emptyCells + currentMonth.length){
			}
			else
			{
				solar = k - emptyCells + 1; // ngay trong thang
				
				if (solar ==date)
					return k;
			}
			
		}
		
	return -1;
}

function ShowLunarDate(dd, mm, yy) // solar day
{
	var currentMonth = getMonth(mm,yy);
	
	var date = dd; // solar day
	
	if (currentMonth.length==0) return;
	
	var ld1 = currentMonth[0]; //  lunar day
	
	var emptyCells = (ld1.jd + 1 ) % 7;
	
	var k = findIndexofTable(emptyCells,currentMonth,date);
	
	ld1 = currentMonth[k - emptyCells];
	
	var s = getDayString( ld1,  dd, mm, yy) + " âm Lịch";
	
	document.getElementById("lunarDate").innerHTML = "" + s;
}

function printmyEmptyCell() {
		return '<td class=tableDayMonth><div class=cn>&nbsp;</div> <div class=am>&nbsp;</div></td>\n';
}

function showInfoDate(yy,mm,dd)
{
	var link = 'index.html?yy=' + yy + '&mm=' + mm + '&dd=' + dd;
	/*$('body').fadeOut( 200, function(){
                          // go to link when animation completes
                          window.location=link;
                          
                          })*/
	window.location.href= link;
}

function printmyCell(lunarDate, solarDate, solarMonth, solarYear) {
	var cellClass, solarClass, lunarClass, solarColor;
	cellClass = "tableDayMonth";
	solarClass = "t2t6";
	lunarClass = "am";
	solarColor = "black";
	var dow = (lunarDate.jd + 1) % 7;
	if (dow == 0) {
		solarClass = "cn";
		solarColor = "red";
	} else if (dow == 6) {
		solarClass = "t7";
		solarColor = "green";
	}
	if (solarDate == today.getDate() && solarMonth == today.getMonth()+1 && solarYear == today.getFullYear()) {
		cellClass = "homnay";
	}
	if (lunarDate.day == 1 && lunarDate.month == 1) {
		cellClass = "tet";
	}
	if (lunarDate.leap == 1) {
		lunarClass = "am2";
	}
	var lunar = lunarDate.day;
	if (solarDate == 1 || lunar == 1) {
		lunar = lunarDate.day + "/" + lunarDate.month;
	}
	var res = "";
	var args = lunarDate.day + "," + lunarDate.month + "," + lunarDate.year + "," + lunarDate.leap;
	args += ("," + lunarDate.jd + "," + solarDate + "," + solarMonth + "," + solarYear);
	res += ('<td class="'+cellClass+'"');
	
	var param = "" + solarYear + ',' + solarMonth +  ',' + solarDate;
	
	if (lunarDate != null) res += (' title="'+getDayName(lunarDate)+'" onClick="showInfoDate(' + param + ');"');
	res += (' <div style=color:'+solarColor+' class="'+solarClass+'">'+solarDate+'</div> <div class="'+lunarClass+'">'+lunar+'</div></td>\n');
	return res;
}


function printmyTable(mm, yy) {
	var i, j, k, solar, lunar, cellClass, solarClass, lunarClass;
	var currentMonth = getMonth(mm, yy);
	if (currentMonth.length == 0) return;
	var ld1 = currentMonth[0];
	var emptyCells = (ld1.jd + 1) % 7;
	var MonthHead = mm + "/" + yy;
	var LunarHead = getYearCanChi(ld1.year);
	var res = "";
	res += ('<table class="tableMonth">\n');
	//res += printHead(mm, yy);
	
	res += '<tr>\n';
	
	for(var i=0;i<=6;i++) {
		
		var row = '<td class=tableDayWeek>'+DAYNAMES[i]+'</td>\n';
		
		res += row;
	}
	res += ('<\/tr>\n');
	
	for (i = 0; i < 6; i++) {
		res += ('<tr>\n');
		for (j = 0; j < 7; j++) {
			k = 7 * i + j;
			if (k < emptyCells || k >= emptyCells + currentMonth.length) {
				res += printmyEmptyCell();
			} else {
				solar = k - emptyCells + 1;
				ld1 = currentMonth[k - emptyCells];
				res += printmyCell(ld1, solar, mm, yy);
			}
		}
		res += ('</tr>\n');
	}
	
	res += ('</table>\n');
	
	return res;
}

function ShowTableMonth()
{
	getSelectedMonth();
	
	var res="";
	
	res += printmyTable(currentMonth,currentYear);
	
	document.getElementById("tableMonth").innerHTML =  res;
	
	getSelectedMonth();
				
	document.SelectedMonthYear.month.value = currentMonth;
				
	document.SelectedMonthYear.year.value = currentYear; 
}

function printMonthYearSelected()
{
	var res="";
	
	getSelectedMonth();
				
	res+= '<form action="" id="select" name="SelectedMonthYear" onchange="viewMonth('+ currentMonth + ',' + currentYear +    '); " >\n';
			
	
	res +='Tháng :';
	
	res += '<select id="monthSelected" name="month" onchange="viewMonth('+ currentMonth + ',' + currentYear +    '); ">\n';
	
	for (i=1;i<=12;i++)
	{
		res+= '<option value="' + i + '">' + i + '<\/option>';
	}
	
	res+= '<\/select>';
	
	res +=' Năm :';
	
	res += '<select id="yearSelected" name="year" onchange="viewMonth('+ currentMonth + ',' + currentYear +    '); ">\n';
	
	for (i=1800;i<=2199;i++)
	{
		res+= '<option value="' + i + '">' + i + '<\/option>';
	}
	
	res+= '<\/select>';
	
	res+= '<\/form>';
	
	document.getElementById("monthYear").innerHTML =  res;
}

function viewMonth(mm, yy) {
	
	mm= parseInt( document.SelectedMonthYear.month.value );
	
	yy = parseInt( document.SelectedMonthYear.year.value ) ;

	window.location = window.location.pathname + '?yy='+yy+'&mm='+mm;
	
	//printMonthYearSelected();
	
	//window.location.reload();
} 