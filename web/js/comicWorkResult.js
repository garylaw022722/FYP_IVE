function ComicWork(coverPage, author, comicName, date, type,comicId) {
        this.coverPage = coverPage;
        this.author = author;
        this.comicName = comicName;
        this.date = date;
        this.type = type;
        this.comicId =comicId;
    }
    
    ComicWork.prototype.getComicId =function(){
        return this.comicId;
    }

    ComicWork.prototype.getCover = function () {
        return this.coverPage;
    }
    ComicWork.prototype.getAuthor = function () {
        return this.author;
    }
    ComicWork.prototype.getName = function () {
        return this.comicName;
    }
    ComicWork.prototype.getDate = function () {
        return this.date;
    }
    ComicWork.prototype.getType = function () {
        return this.type;
    }
