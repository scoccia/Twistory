// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function show_hide()
{
    nuovo_stato = (document.getElementById("key").style.display == 'none') ? 'block' : 'none';
    document.getElementById("key").style.display = nuovo_stato;
}

function Expand_Image(id)
{   
  var newheight = "38em"; // Warning: be sure that style.css height is different to newheight 
  var newmargin = "0 -20% 0 -20%";
  
  if (document.getElementById(id).style.height != newheight)
  {     
    document.getElementById(id).style.height= newheight;
    document.getElementById(id).style.margin= newmargin;    
  }
  else
  {
    document.getElementById(id).style.height= "";
    document.getElementById(id).style.margin= "";
  }
}
