import nodemailer from 'nodemailer';

const sendEmail = async ({ to, subject, text }) => {
    try {
        console.log("EMAIL_USER:", process.env.EMAIL_USER);
        console.log("EMAIL_PASS:", process.env.EMAIL_PASS);

        const transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: process.env.EMAIL_USER,
                pass: process.env.EMAIL_PASS
            }
        });

        await transporter.sendMail({
            from: `"Mi App" <${process.env.EMAIL_USER}>`,
            to,
            subject,
            text
        });
    } catch (error) {
        console.error("Email send error:", error);
        throw error;
    }
};

export default sendEmail;