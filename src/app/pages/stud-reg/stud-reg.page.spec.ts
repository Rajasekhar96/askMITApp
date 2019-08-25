import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { StudRegPage } from './stud-reg.page';

describe('StudRegPage', () => {
  let component: StudRegPage;
  let fixture: ComponentFixture<StudRegPage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ StudRegPage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StudRegPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
