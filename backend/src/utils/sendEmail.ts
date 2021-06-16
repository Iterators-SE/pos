import * as nodemailer from "nodemailer";

export async function sendEmail(name: string, email: string, url: string, { confirm = true }) {
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 465,
        secure: true, // true for 465, false for other ports
        auth: {
            user: process.env.NODEMAILER_USER,
            pass: process.env.NODEMAILER_PASSWORD,
        },
    });

    console.log(`transporter ${transporter}`)

    const message = confirm ? `
    <p>Welcome to XPOS!<p><br><p>You've taken the first steps towards levelling up <strong>${name}</strong>, now all that's left to do is confirm!<p>
    <p>Please click <a href="${url}">here</a> to confirm your account!<p>
    <br>
    <p><em>Sincerely,</em><p>
    <p><em>The XPOS Team</em><p>
    ` : `
    Hi!
        
        We heard you forgot your password but that's okay - maybe we can help?

        Please click <a href="${url}">here</a> to reset your password for ${name}!

        <i>Sincerely,
        The XPOS Team</i>
    `;

    let mailOptions = {
        from: process.env.NODEMAILER_USER, // sender
        to: email, //recipient
        subject: "Please confirm your email for XPOS",
        text: "test",
        html: message
    }


    const info = await transporter.sendMail(mailOptions);

    // debugging purposes only
    // TODO [03-21-2021]: REMOVE THIS
    console.log(`Message: ${info.messageId}`);
    console.log(`Preview URL: ${nodemailer.getTestMessageUrl(info)}`);
}