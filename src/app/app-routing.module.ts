import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  // { path: 'home', loadChildren: () => import('./home/home.module').then( m => m.HomePageModule)},
  {
    path: 'home',
    loadChildren: './pages/home/home.module#HomePageModule'
  },
  { path: 'login', loadChildren: './pages/login/login.module#LoginPageModule' },
  { path: 'register', loadChildren: './pages/register/register.module#RegisterPageModule' },
  { path: 'settings', loadChildren: './pages/settings/settings.module#SettingsPageModule' },
  { path: 'studentlist', loadChildren: './pages/studentlist/studentlist.module#StudentlistPageModule' },
  { path: 'stud-reg', loadChildren: './pages/stud-reg/stud-reg.module#StudRegPageModule' },
  { path: 'rankings', loadChildren: './pages/rankings/rankings.module#RankingsPageModule' },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
