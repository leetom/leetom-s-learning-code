var scroll_list;
var main_pic_scroll;

function init_pic_scroll()
{
	main_pic_scroll = new iScroll('scroller_imglist', {
		snap:true,
		overflow:'hidden',
		momentum:false,
		hScrollbar:false,
		disableTouchEvents:false,
		onScrollEnd: function () {
			document.querySelector('#indicator_imglist > li.active').className = '';
			document.querySelector('#indicator_imglist > li:nth-child(' + (this.pageX+1) + ')').className = 'active';
			$('#prev_imglist').add('#next_imglist').removeClass('c_grey');
			if(this.pageX <= 0)
			{
			    $('#prev_imglist').addClass('c_grey');
			}
			else if(this.pageX >= 2)
			{
			    $('#next_imglist').addClass('c_grey');
			}
		}
	 });
	 $('#prev_imglist').click(function(){
	 	main_pic_scroll.scrollToPage('prev', 0);
	 });
	 $('#next_imglist').click(function(){
	 	main_pic_scroll.scrollToPage('next', 0);
	 });
}

$(function(){
	init_pic_scroll();
});