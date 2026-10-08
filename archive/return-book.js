document.addEventListener("DOMContentLoaded",function(){
  var nav=document.querySelector(".visible-links");
  if(!nav||document.getElementById("return-book"))return;
  var li=document.createElement("li");
  li.className="masthead__menu-item";
  li.innerHTML='<a id="return-book" href="/" title="Back to Dasein" aria-label="Back to the landing page"><svg viewBox="0 0 44 52" width="22" height="26" aria-hidden="true"><rect x="4" y="3" width="34" height="46" rx="2" fill="#10203a" stroke="#e7c56a" stroke-width="2"/><rect x="8" y="3" width="3" height="46" fill="#1c3158"/><polygon points="16,12 17.2,15.4 21,15.6 18.2,17.8 19.2,21.2 16,19.4 12.8,21.2 13.8,17.8 11,15.6 14.8,15.4" fill="#e7c56a"/><polygon points="28,20 28.8,22.2 31.2,22.3 29.4,23.7 30,26 28,24.8 26,26 26.6,23.7 24.8,22.3 27.2,22.2" fill="#e7c56a"/><polygon points="22,30 22.7,31.8 24.6,31.9 23.1,33.1 23.6,35 22,33.9 20.4,35 20.9,33.1 19.4,31.9 21.3,31.8" fill="#e7c56a"/></svg></a>';
  nav.appendChild(li);
});
