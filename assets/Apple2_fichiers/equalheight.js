(function($){$.fn.equalHeight=function(options){var element=this;$(window).on("resize",function(){var init=0;var default_settings={max_width:0,min_width:0,dimension:"none",referer:"max"}
var settings=$.extend(default_settings,options);var condition01=settings.min_width!=0&&settings.max_width!=0&&$(window).innerWidth()>=settings.min_width&&$(window).innerWidth()<=settings.max_width,condition02=settings.min_width!=0&&settings.max_width==0&&$(window).innerWidth()>=settings.min_width,condition03=settings.min_width==0&&settings.max_width!=0&&$(window).innerWidth()<=settings.max_width,condition04=settings.min_width==0&&settings.max_width==0;if(condition01||condition02||condition03||condition04){element.each(function(){$(this).height("")
if(init<=$(this).height()&&settings.referer=="max"||init>=$(this).height()&&settings.referer=="min")
init=$(this).height()})
if(settings.dimension=="outer")
return element.outerHeight(init);else if(settings.dimension=="inner")
return element.innerHeight(init);else return element.height(init)}else{return element.height("")}}).trigger('resize')}})(jQuery)