import { Component, OnInit } from '@angular/core';
import { LoadingController } from '@ionic/angular';
import { HttpClient } from '@angular/common/http';
import { CommfunService } from 'src/app/services/commfun.service';
@Component({
  selector: 'app-rankings',
  templateUrl: './rankings.page.html',
  styleUrls: ['./rankings.page.scss'],
})
export class RankingsPage implements OnInit {

  public jsonItems: any;
  constructor(
    public http: HttpClient,
    public loadingCtrl: LoadingController,
    private myFunc: CommfunService,
    ) { }
  ngOnInit() {
    this.getStudentRankings();
  }

  async  getStudentRankings() {
    let data: any;
    const url = this.myFunc.domainURL + 'handlers/mit.ashx?mode=selRankings';
    const loading = await this.loadingCtrl.create({
      message: 'Please Wait...',
    });
    data = this.http.get(url);
    loading.present().then(() => {
      data.subscribe(result => {
        console.log(result);
        this.jsonItems = result;
        loading.dismiss();
      });
      // return loading.present();
    }, error => {
      console.log(error);
      loading.dismiss();
    });
  }

}
