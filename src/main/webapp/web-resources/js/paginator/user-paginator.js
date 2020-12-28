/**
 * This class is used for paging `user` objects
 *
 * @see PageHelper
 */
class UserPaginator extends PageHelper {
    constructor(pageLength, bindingArea) {
        super(pageLength);
        this.bindingArea = bindingArea;
    }

    static deleteUser(userId, removeElementTarget) {
        if(deleteUserById(userId) === 1) {
            removeElementTarget.remove();
            dialogCloseTrigger($('#user-dialog'));
        }
    }

    bindUsers(page, pageInfo) {
        let users = pageInfo['list'];
        let count = 0;

        this.bindingArea.empty();

        if (users.length === 0) {
            this.bindingArea.append(this.getEmptyRowElement(10));
        } else {
            for(let i = 0; i < users.length; i++) {
                let user = users[i];

                this.bindingArea.append(`
                    <tr id="${user.userId}">
                        <td>${user.userId}</td>
                        <td>${user.name}</td>
                        <td>${user.nickName == null ? "미설정" : user.nickName}</td>
                        <td>${user.phone}</td>
                        <td>${user.email}</td>
                        <td class="aba">${user.type.value}</td>
                        <td class="aba">${user.role.value}</td>
                        <td width="10%" onclick="event.cancelBubble=true">
                            <span class="border-side">
                                <i class="fas fa-eye" onclick="window.open('/admin/users/user_detail?id='.concat('${user.userId}'))"></i>
                                <i class="fas fa-pen"></i>
                                <i class="fas fa-trash-alt"
                                    onclick="dialogInitializer($('#user-dialog'), '${user.userId}', '${user.userId}')">
                                </i>
                            </span>
                        </td>
                    </tr>
                `)
            }
        }
    }

    bindOffersByOwner(page, pageInfo) {
        let users = pageInfo['list'];
        let count = 0;

        this.bindingArea.empty();

        if (users.length === 0) {
            this.bindingArea.append(this.getEmptyRowElement(10));
        } else {
            for(let i = 0; i < users.length; i++) {
                let user = users[i];

                this.bindingArea.append(`
                    <tr>
                        <td onclick="foldTrigger($(this))">
                            <img src="/web-resources/img/basic/keyboard_arrow_up-24px.svg" style="border: 1px solid black; border-radius: 45px;">
                        </td>
                        <td class="userId">${user.userId}</td>
                        <td>${user.name}</td>
                        <td>${user.phone}</td>
                        <td class="aba">${user.type.value}</td>
                    </tr>
                `)
            }
        }
    }
}
