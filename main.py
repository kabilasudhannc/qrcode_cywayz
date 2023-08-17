from flask import Flask, render_template, request
import qrcode

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        store_id = request.form.get('store_id')
        store_name = request.form.get('store_name')
        url = f"https://www.cxocywayz.com/?store_id={store_id}"

        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            box_size=10,
            border=4,
        )

        qr.add_data(url)
        qr.make(fit=True)

        qr_image = qr.make_image(fill_color="black", back_color="white")

        qr_image_path = f"static/{store_name}.png"
        qr_image.save(qr_image_path)

        return render_template('index.html', qr_image_path=qr_image_path)

    return render_template('index.html', qr_image_path=None)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=4000)
