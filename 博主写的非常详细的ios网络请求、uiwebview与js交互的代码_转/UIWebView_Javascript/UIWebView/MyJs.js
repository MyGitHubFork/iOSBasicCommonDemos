function showSheet(title,cancelButtonTitle,destructiveButtonTitle,otherButtonTitle) {
    var url='kcactionsheet://?';
    var paramas=title+'&'+cancelButtonTitle+'&'+destructiveButtonTitle;
    if(otherButtonTitle){
        paramas+='&'+otherButtonTitle;
    }
    window.location.href=url+ encodeURIComponent(paramas);
}
var blog=document.getElementById('blog');
blog.onclick=function(){
    showSheet('系统提示','取消','确定',null);
};