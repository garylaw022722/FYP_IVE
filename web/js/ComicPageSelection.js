
function  ComicPageSelection(comicSession) {
    this.comicSession = comicSession;
    this.comicPage = [];
}
ComicPageSelection.prototype.setComicPage = function (pageNumSet) {
    this.comicPage = pageNumSet;
}
ComicPageSelection.prototype.setComicSession = function (ComicSession) {
    this.comicSession = ComicSession;
}
ComicPageSelection.prototype.getComicSession = function () {
    return  this.comicSession;
}
ComicPageSelection.prototype.getComicPage = function () {
    return this.comicPage;
}