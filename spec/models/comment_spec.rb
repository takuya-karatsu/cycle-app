require 'rails_helper'

describe Comment do
  before do
    @comment = FactoryBot.build(:comment, message: Faker::Lorem.sentence)
  end

  describe 'コメント投稿' do
    context 'コメント投稿がうまくいく時' do
      it 'コメント存在すれば登録できる' do
        expect(@comment).to be_valid
      end
    end
    context 'コメント投稿がうまくいかない時' do
      it 'コメントが空だと登録できない' do
        @comment.message = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントを入力してください")
      end
      it 'コメントが101文字以上だと登録できない' do
        @comment.message = Faker::Lorem.characters(number: 101)
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントは100文字以内で入力してください")
      end
    end
  end
end
