import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators} from '@angular/forms';
import { Router } from '@angular/router';
import { CommfunService } from 'src/app/services/commfun.service';
import { LoadingController, ToastController } from '@ionic/angular';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-stud-reg',
  templateUrl: './stud-reg.page.html',
  styleUrls: ['./stud-reg.page.scss'],
})
export class StudRegPage implements OnInit {

  validations_form: FormGroup;
  constructor(
    public formBuilder: FormBuilder,
    private router: Router,
    private myFunc: CommfunService,
    public http: HttpClient,
    public loadingCtrl: LoadingController,
    public toastController: ToastController,) { }

  ngOnInit() {
    this.validations_form = this.formBuilder.group({
      regNum: new FormControl('', Validators.compose([
        Validators.maxLength(6),
        Validators.minLength(1),
        // Validators.pattern('^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]+$'),
        Validators.required
      ])),
      studName: new FormControl('', Validators.compose([
        Validators.required
      ])),
      dob: new FormControl('', Validators.compose([
        Validators.required
      ])),
      gender: new FormControl('', Validators.compose([
        Validators.required
      ])),
      child: new FormControl('', Validators.compose([
        Validators.required
      ])),
      fatherName: new FormControl('', Validators.compose([
        Validators.required
      ])),
      motherName: new FormControl('', Validators.compose([
        Validators.required
      ])),
      mathsMarks: new FormControl('', Validators.compose([
        Validators.maxLength(3),
        Validators.minLength(2),
        Validators.required
      ])),
      physicsMarks: new FormControl('', Validators.compose([
        Validators.maxLength(3),
        Validators.minLength(2),
        Validators.required
      ])),
      chemistry: new FormControl('', Validators.compose([
        Validators.maxLength(3),
        Validators.minLength(2),
        Validators.required
      ])),
    });
  }

  validation_messages = {
    regNum: [
      { type: 'required', message: 'Registed number is required.' },
      { type: 'minlength', message: 'Enter the correct register number.' },
      { type: 'maxlength', message: 'Enter the correct register number' },
    ],
    studName: [
      { type: 'required', message: 'Student Name is required.' },
    ],
    dob: [
      { type: 'required', message: 'Date of birth is required.' },
    ],
    gender: [
      { type: 'required', message: 'Please select the Gender' },
    ],
    child: [
      { type: 'required', message: 'Please select the childern' },
    ],
    fatherName: [
      { type: 'required', message: 'Please Enter the Father Name' },
    ],
    motherName: [
      { type: 'required', message: 'Please Enter the Mother Name' },
    ],
    mathsMarks: [
      { type: 'required', message: 'please Enter the Marks.' },
      { type: 'minlength', message: 'You are not Eligible to Apply.' },
      { type: 'maxlength', message: 'Enter the correct Marks' },
    ],
    physicsMarks: [
      { type: 'required', message: 'please Enter the Marks.' },
      { type: 'minlength', message: 'You are not Eligible to Apply.' },
      { type: 'maxlength', message: 'Enter the Correct Marks' },
    ],
    chemistry: [
      { type: 'required', message: 'please Enter the Marks.' },
      { type: 'minlength', message: 'You are not Eligible to Apply.' },
      { type: 'maxlength', message: 'Enter the Correct Marks' },
    ],
  };

  convertDate(dob) {
    return dob.substring(0, 10);
    // const dateRegex = /^([0-2][0-9]|(3)[0-1])(-)(((0)[0-9])|((1)[0-2]))(-)\d{4}$/i;
    // const find = dob.match(dateRegex);
    // return find;
  }

  async onSubmit(values) {
    console.log(values);
    // console.log(this.convertDate(values.dob));
    // console.log(values.email);
   let data: any;
    // tslint:disable-next-line:max-line-length
    const url = this.myFunc.domainURL + 'handlers/mit.ashx?mode=insRegStud&studentRegNo=' + values.regNum + '&studentName=' + values.studName + '&dateOfBirth=' + this.convertDate(values.dob) + '&fatherName=' + values.fatherName + '&motherName=' + values.motherName + '&mathsMarks=' + values.mathsMarks + '&physicsMarks=' + values.physicsMarks + '&chemistryMarks=' + values.chemistry + '&child=' + values.child + '&gender=' + values.gender;
    const loading = await this.loadingCtrl.create({
      message: 'Student Mark Registration...',
    });
    data = this.http.get(url);
    loading.present().then(() => {
      data.subscribe(result => {
        console.log(result);
        if (result[0].status === 'success') {
          this.validations_form.reset();
          this.presentToast('Registered Sucessfully 😄');
          this.router.navigate(['/home']);
        }
        loading.dismiss();
      });
      // return loading.present();
    }, error => {
      console.log(error);
      this.presentToast('Error Occured 😞...!');
      loading.dismiss();
    });
  }

  async presentToast(msg) {
    const toast = await this.toastController.create({
      message: msg,
      duration: 2000
    });
    toast.present();
  }

}
