function increaseMaxZoomFactor() {
    var element = document.createElement('meta');
    element.name = "viewport";
    element.content = "minimum-scale=0.6; maximum-scale=0.6;  initial-scale=0.6; user-scalable=yes; width=640";
    var head = document.getElementsByTagName('head')[0];
    head.appendChild(element);
}

function getElementsClass(classnames){
    var classobj= new Array();
    var classint=0;
    var tags=document.getElementsByTagName("*");
    for(var i in tags){
        if(tags[i].nodeType==1){
            if(tags[i].getAttribute("class") == classnames)
            {
                classobj[classint]=tags[i];
                classint++;
            }
        }
    }
    return classobj;
}

function hideElemets() {
    document.getElementsByTagName('body')[0].style.background='white';

    var kefu = document.getElementById('box-kefu');
    kefu.style.display = "none";
    
    var code = document.getElementById('code');
    code.style.display = "none";

    var goTop = document.getElementById('gotop');
    goTop.parentNode.removeChild(goTop);

    var topBg = getElementsClass('topbg')[0];
    topBg.style.display = "none";

    var nav = getElementsClass('nav')[0];
    nav.style.display = "none";

    var center = getElementsClass('nav')[0];
    center.style.background = "white";

    var bottom = getElementsClass('bottom')[0];
    bottom.style.display = "none";
}