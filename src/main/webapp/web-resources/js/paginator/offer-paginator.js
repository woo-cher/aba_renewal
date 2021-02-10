/**
 * This class is used for paging `offer` objects
 *
 * Need a conditions below)
 *
 * @see PageHelper
 * 1) `sessionUserId`
 *  > Because `offer` model has `register` column
 */
class OfferPaginator extends PageHelper {
    constructor(pageLength, bindingArea) {
        super(pageLength);
        this.bindingArea = bindingArea;
    }

    static deleteOffer(offerId, removeElementTarget) {
        if(deleteOfferById(offerId) === 1) {
            removeElementTarget.remove();
            dialogCloseTrigger($('#offer-dialog'));
        }
    }

    bindOffers(page, pageInfo) {
        let offers = pageInfo['list'];
        let count = 0;

        this.bindingArea.empty();

        if (offers.length === 0) {
            this.bindingArea.append(this.getEmptyRowElement(10));
        } else {
            for(let i = 0; i < offers.length; i++) {
                let offer = offers[i];
                let offerId = offer.id;

                this.bindingArea.append(`
                <tr>
                    <td class="aba">${offerId}</td>
                    <td class="offer${offer.id}">
                        ${offer.offerAddress.jibun}
                    </td>
                    <td>${offer.offerAddress.ho !== null ? offer.offerAddress.ho : "정보없음"}</td>
                    <td>${offer.type.value} / ${offer.dealType.value}</td>
                    <td>
                        <span>${offer.deposit}/${offer.monthlyPrice} +</span>
                        <span class="aba"> ${offer.managementPrice}</span>
                    </td>
                    <td class="aba status" onclick="dialogInitializer($('#status-dialog'), null, ${offerId})">${offer.status.value}</td>
                    <td>${offer.createdAt.slice(2, 10).replaceAll("-", ".")}</td>
                    <td width="20%">
                        <span class="border-side">
                            <i class="fas fa-eye" title="매물 상세보기" onclick="window.open('/offers/${offerId}')" ></i>
                            <i class="fas fa-pen" title="매물 수정하기"
                                onclick="window.open('/offers/form?offerId=${offerId}', '', 'width=1400, height=950, top=30, left=250')">
                            </i>
                            <i class="fas fa-trash-alt" title="매물 삭제하기"
                               onclick="dialogInitializer($('#offer-dialog'), $('.offer${offerId}').text(), ${offerId})"
                            >
                            </i>
                        </span>
                    </td>
                </tr>
                `)
            }
        }
    }
}
