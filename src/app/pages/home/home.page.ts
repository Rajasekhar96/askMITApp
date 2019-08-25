import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Storage } from '@ionic/storage';
@Component({
  selector: 'app-home',
  templateUrl: './home.page.html',
  styleUrls: ['./home.page.scss'],
})
export class HomePage implements OnInit {
  public userRole: string;
  constructor(
    private router: Router,
    private storage: Storage,
  ) {
    this.storage.get('lsUserID').then((val) => {
      if (val != null) {
        this.storage.get('lsUserRole').then((role) => {
          this.userRole = role;
          console.log(role);
        });
      } else {
        this.router.navigateByUrl('/login');
      }
    });
  }

  ngOnInit() {
  }

  goToRankingList() {
    this.router.navigateByUrl('/rankings');
  }

  goToStudentList() {
    this.router.navigateByUrl('/studentlist');
  }

  goToStudRegister() {
    this.router.navigateByUrl('/stud-reg');
  }

  goToSettings() {
    this.router.navigateByUrl('/settings');
  }

}
