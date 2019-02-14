require 'rails_helper'
describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  # let(:messages) { create_list(:message, 3, group_id: group.id) }

  describe 'GET #index' do
    context 'user signed in' do
      before do
        login user
        get :index, params: { group_id: group.id }
      end
      it 'assigns @messages' do
        messages = create_list(:message, 3, group_id: group.id)
        expect(assigns(:messages)).to match_array(messages)
      end
      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)
      end
      it 'assigns @group' do
        expect(assigns(:current_group)).to eq group
      end
      it 'renders template :index' do
        expect(response).to render_template :index
      end
    end
    context 'user signed out' do
      before do
        get :index, params: { group_id: group.id }
      end
      it 'redirects to sign_in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'user signed in' do
      before do
        login user
      end
      context 'succeed in save' do
        it 'saves message' do
          expect {
            post :create, params: {
              message: {
                body: '迷子　きゅうりょう　なおさら　つなひき',
                image: nil
              },
              user_id: user.id,
              group_id: group.id
            }
          }.to change(user.messages, :count).by(1)
        end
        it 'redirects to messages#index' do
          post :create, params: {
            message: {
              body: '迷子　きゅうりょう　なおさら　つなひき',
              image: nil
            },
            user_id: user.id,
            group_id: group.id
          }
          expect(response).to redirect_to(group_messages_path)
        end
      end
      context 'fail in save' do
        it 'not saves message' do
          expect {
            post :create, params: {
              message: {
                body: nil,
                image: nil
              },
              user_id: user.id,
              group_id: group.id
            }
          }.to_not change(user.messages, :count)
        end
        it 'renders template :index' do
          post :create, params: {
            message: {
              body: nil,
              image: nil
            },
            user_id: user.id,
            group_id: group.id
          }
          expect(response).to render_template :index
        end
      end
    end
    context 'user signed out' do
      it 'redirects to sign_in' do
        post :create, params: {
          message: {
            body: '迷子　きゅうりょう　なおさら　つなひき',
            image: nil
          },
          user_id: user.id,
          group_id: group.id
        }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
