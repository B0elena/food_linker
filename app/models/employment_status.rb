class EmploymentStatus < ActiveHash::Base
  self.data = [
    { id: 1, name: '雇用形態' },
    { id: 2, name: '正社員' },
    { id: 3, name: '契約社員' },
    { id: 4, name: 'アルバイト' },
    { id: 5, name: 'その他' },
  ]
  end
