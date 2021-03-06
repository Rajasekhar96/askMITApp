import { Component, OnInit } from '@angular/core';
import { Storage } from '@ionic/storage';
import { Router } from '@angular/router';
@Component({
  selector: 'app-settings',
  templateUrl: './settings.page.html',
  styleUrls: ['./settings.page.scss'],
})
export class SettingsPage implements OnInit {

  constructor(private storage: Storage, private router: Router) { }

  ngOnInit() {
  }

  logOutFn() {
    this.storage.clear().then(() => {
      console.log('all keys are cleared');
    });
    this.router.navigate(['/login']);

    // this.router.navigateByUrl('/login');
  }
}
