
function  CreateEmail (receiver, subject, body){
        this.receiver =receiver;
        this.subject = subject;
        this.body = body;
    }
    
    CreateEmail.prototype.sendEmail = function () {
        Email.send({
            Host: "smtp.gmail.com",
            Username: "law190444956@gmail.com",
            Password: "lmyucmfqcuhmfbbd",
            To: this.receiver,
            From: "law190444956@gmail.com",
            Subject: this.subject,
            Body: this.body
        }).then(
                
        );





}